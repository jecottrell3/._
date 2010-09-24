define(`each', `form[`$1']
ifelse(`$#', `1', , `$0(shift($@))')')dnl
dnl
each(2, 3, 5, 7, 11)dnl

define(`beach', `patsubst(`$1', `{}', `$2')
ifelse(`$#', `2', , `$0(`$1', shift(shift($@)))')')dnl
dnl
beach(`prime[{}]', 2, 3, 5, 7, 11)dnl

define(`PKGS', defn(`PKGS')`,pkgs.base')dnl


define(`append', `define(`$1', defn(`$1')`,shift($@)')')dnl

define(`yoyo', `john, mojo')dnl
yo = yoyo
append(`yoyo', `red', `lectroids', `perfect', `tommy') 
yo = yoyo

beach(`<{}>', yoyo)

