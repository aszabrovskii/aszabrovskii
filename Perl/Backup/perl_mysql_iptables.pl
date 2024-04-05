#!/usr/bin/perl 
use IPTables::IPv4;
use  DBI;
$table=IPTables::IPv4::init('filter'); # подключение модуля к таблице filter.

$dbh=DBI->connect('DBI:mysql:billing',undef,undef'); #подключение к базе billing

$chainname='trafin'; #имя цепочки
@rules=$table->list_rules($chainname); 
$i=0;

# получаем массив ссылок на состояние всех правил в цепочке Для хранения
# данных создана таблица с полями: ID,IP,TRAF,SUM, где поле TRAF
# используется для отсчета оставшегося трафика, а SUM для суммирования
# скаченного трафика. Обработка массива @rules

foreach $lin (@rules){
    $per=$$lin{"destination"}; # получения исходящего адреса

    $jump=$$lin{"jump"}
    $sql="SELECT ID,IP,TRAF,SUM FROM traffik WHERE IP='$per'"; 

    # проверка на наличие ip в таблице
    $sth=$dbh->prepare($sql); #подготовка запроса
    $sth->execute; #выполнение запроса
    ($id,$ip,$traf,$sum)=$sth->fetchrow_array;# получения данных

    if($id ne "") # проверка на отсутсвия ip в таблице
      {  # ip в таблице найден
      $traf-=$$lin{"bcnt"};#вычитаем трафик 
      $traf=0 if $traf<=0 ;
      $sum+=$$lin{"bcnt"}; #сумируем весь трафик
      $sql="UPDATE traffik SET TRAF=$traf, SUM=$sum WHERE ID=$id";# забиваем таблицу

      if(($traf<=0)&&($$lin{"jump"} ne "DROP"))# Блокировка таблици при окончании трафика
       {
        $$lin{"jump"}="DROP"; # -j DROP
        $$lin{"pcnt"}=0;     #обнуление счетчика пакетов
        $$lin{"bcnt"}=0;     #обнуление счетчика байтов
        $table->replace_entry($chainname, $lin, $i)or die"Невозможно DROP'нуть правило :$!\n"; 
        #изменение правила
       }elsif(($traf>0)&&($$lin{"jump"}eq "DROP")){
        $table->replace_entry($chainname, {destination=>$$lin{"destination"},jump=>'ACCEPT'}, $i); 
        # открываем доступ, если он был закрыт
       };
       $dbh->do($sql);#Выполнения запроса
    } else { #нет ip в таблице
        #удаляем из netfilter  правило с этим ip
       $table->delete_num_entry('billing',$i)or die "Невозможно удалить правило из цепочки chainname :$!\n";
       $i--;
    };
    $i++;
};
$table->zero_entries($chainname); # Обнуление счетчиков байтов
$success = $table->commit();	  # Завершаем работу с netfilter
$dbh->disconnect(); # Завершаем работу с MySQL.
