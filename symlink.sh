read -p "Symlink dotfiles? [yn] " answer
 if [[ $answer = y ]] ; then
   mkdir -p ~/.irssi
   cd $DOTDIR

   # delete all dotfiles present, suppress stderr
   for f in *; do
     if [[ $f = "config" ]] ; then rm ~/.irssi/$f 2> /dev/null; fi
     rm ~/.$f 2> /dev/null;
   done

   # symlink all dotfiles
   for f in *; do
     if [[ $f = "config" ]] ;
       then
         ln -s $(realpath ./$f) ~/.irssi/$f
         file ~/.irssi/$f
       else
         ln -s $(realpath ./$f) ~/.$f
         file ~/.$f
     fi
   done
 fi
