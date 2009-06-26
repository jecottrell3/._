return	# DEPRECATED

export	IAM=$(id -un)
case   $IAM in
(root)	export	RBJ=/root;;
(*)	export	RBJ=/home/$IAM;;
esac

export	INIT=$RBJ/init
export	HOME=$RBJ/$1

set $(df / | sed -n /.dev./s///p)

#Filesystem           1K-blocks      Used Available Use% Mounted on
#/dev/hda14             4743776    688288   3814516  16% /

mkdir -p $HOME; cd $HOME

test -d  init ||
ln -s ../init .

test -f	.bash_profile && #|| source $INIT/ialize
source	.bash_profile
