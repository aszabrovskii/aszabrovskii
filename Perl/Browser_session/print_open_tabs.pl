   #!/usr/bin/perl

   use strict;
   use JSON;
  
   # Читаем содержимое в файл
   my $json_text = <>;
   # Преобразуем JSON-блок в хэш, предварительно убирая лидирующие скобки
   my $perl_scalar = from_json(substr($json_text,1,-1), {utf8 => 1});

   # Последовательно перебираем открытые окна и табы
   foreach my $windows_block (@{$perl_scalar->{windows}}){
       foreach my $tabs_block (@{$windows_block->{tabs}}){
           # выводим активные табы по их индексу
           if ($tabs_block->{"index"} > 0){
               my $idx = $tabs_block->{"index"}-1;
               print "$tabs_block->{entries}[$idx]{url}\t$tabs_block->{entries}[$idx]{title}\n";
           }
       }
   }
