¥
zC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Logging.Abstractions\Properties\AssemblyInfo.cs
[ 
assembly 	
:	 

AssemblyTitle 
( 
$str C
)C D
]D E
[ 
assembly 	
:	 

AssemblyDescription 
( 
$str !
)! "
]" #
[ 
assembly 	
:	 
!
AssemblyConfiguration  
(  !
$str! #
)# $
]$ %
[ 
assembly 	
:	 

AssemblyCompany 
( 
$str 
) 
] 
[ 
assembly 	
:	 

AssemblyProduct 
( 
$str E
)E F
]F G
[		 
assembly		 	
:			 

AssemblyCopyright		 
(		 
$str		 0
)		0 1
]		1 2
[

 
assembly

 	
:

	 

AssemblyTrademark

 
(

 
$str

 
)

  
]

  !
[ 
assembly 	
:	 

AssemblyCulture 
( 
$str 
) 
] 
[ 
assembly 	
:	 


ComVisible 
( 
false 
) 
] 
[ 
assembly 	
:	 

Guid 
( 
$str 6
)6 7
]7 8
[ 
assembly 	
:	 

AssemblyVersion 
( 
$str $
)$ %
]% &
[ 
assembly 	
:	 

AssemblyFileVersion 
( 
$str (
)( )
]) *Ï
wC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Logging.Abstractions\Ports\ILoggerService.cs
	namespace 	
TrickTakingMissions
 
. 
Logging %
.% &
Abstractions& 2
.2 3
Ports3 8
{ 
public 

	interface 
ILoggerService #
{ 
void 
Trace 
( 
string 
messageTemplate )
,) *
params+ 1
object2 8
[8 9
]9 :
messageArguments; K
)K L
;L M
void

 
Debug

 
(

 
string

 
messageTemplate

 )
,

) *
params

+ 1
object

2 8
[

8 9
]

9 :
messageArguments

; K
)

K L
;

L M
void 
Information 
( 
string 
messageTemplate  /
,/ 0
params1 7
object8 >
[> ?
]? @
messageArgumentsA Q
)Q R
;R S
void 
Warning 
( 
string 
messageTemplate +
,+ ,
params- 3
object4 :
[: ;
]; <
messageArguments= M
)M N
;N O
void 
Error 
( 
string 
messageTemplate )
,) *
params+ 1
object2 8
[8 9
]9 :
messageArguments; K
)K L
;L M
void 
Error 
( 
	Exception 
	exception &
,& '
string( .
messageTemplate/ >
,> ?
params@ F
objectG M
[M N
]N O
messageArgumentsP `
)` a
;a b
void 
Fatal 
( 
string 
messageTemplate )
,) *
params+ 1
object2 8
[8 9
]9 :
messageArguments; K
)K L
;L M
void 
Fatal 
( 
	Exception 
	exception &
,& '
string( .
messageTemplate/ >
,> ?
params@ F
objectG M
[M N
]N O
messageArgumentsP `
)` a
;a b
} 
} À
wC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Logging.Abstractions\Ports\ILoggerFactory.cs
	namespace 	
TrickTakingMissions
 
. 
Logging %
.% &
Abstractions& 2
.2 3
Ports3 8
{ 
public 

	interface 
ILoggerFactory #
{ 
ILoggerService 
CreateLogger #
(# $
Type$ (

callerType) 3
)3 4
;4 5
ILoggerService

 
CreateLogger

 #
<

# $
TCaller

$ +
>

+ ,
(

, -
)

- .
;

. /
} 
} ô
tC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Logging.Abstractions\NullLoggerService.cs
	namespace 	
TrickTakingMissions
 
. 
Logging %
.% &
Abstractions& 2
{ 
public 

sealed 
class 
NullLoggerService )
:* +
ILoggerService, :
{ 
public		 
static		 
ILoggerService		 $
Instance		% -
{		. /
get		0 3
;		3 4
}		5 6
=		7 8
new		9 <
NullLoggerService		= N
(		N O
)		O P
;		P Q
private 
NullLoggerService !
(! "
)" #
{ 	
} 	
public 
void 
Trace 
( 
string  
messageTemplate! 0
,0 1
params2 8
object9 ?
[? @
]@ A
messageArgumentsB R
)R S
{ 	
} 	
public 
void 
Debug 
( 
string  
messageTemplate! 0
,0 1
params2 8
object9 ?
[? @
]@ A
messageArgumentsB R
)R S
{ 	
} 	
public 
void 
Information 
(  
string  &
messageTemplate' 6
,6 7
params8 >
object? E
[E F
]F G
messageArgumentsH X
)X Y
{ 	
} 	
public 
void 
Warning 
( 
string "
messageTemplate# 2
,2 3
params4 :
object; A
[A B
]B C
messageArgumentsD T
)T U
{ 	
} 	
public 
void 
Error 
( 
string  
messageTemplate! 0
,0 1
params2 8
object9 ?
[? @
]@ A
messageArgumentsB R
)R S
{   	
}!! 	
public## 
void## 
Error## 
(## 
	Exception## #
	exception##$ -
,##- .
string##/ 5
messageTemplate##6 E
,##E F
params##G M
object##N T
[##T U
]##U V
messageArguments##W g
)##g h
{$$ 	
}%% 	
public'' 
void'' 
Fatal'' 
('' 
string''  
messageTemplate''! 0
,''0 1
params''2 8
object''9 ?
[''? @
]''@ A
messageArguments''B R
)''R S
{(( 	
})) 	
public++ 
void++ 
Fatal++ 
(++ 
	Exception++ #
	exception++$ -
,++- .
string++/ 5
messageTemplate++6 E
,++E F
params++G M
object++N T
[++T U
]++U V
messageArguments++W g
)++g h
{,, 	
}-- 	
}.. 
}// á

tC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Logging.Abstractions\NullLoggerFactory.cs
	namespace 	
TrickTakingMissions
 
. 
Logging %
.% &
Abstractions& 2
{ 
public 

sealed 
class 
NullLoggerFactory )
:* +
ILoggerFactory, :
{ 
public		 
static		 
ILoggerFactory		 $
Instance		% -
{		. /
get		0 3
;		3 4
}		5 6
=		7 8
new		9 <
NullLoggerFactory		= N
(		N O
)		O P
;		P Q
private 
NullLoggerFactory !
(! "
)" #
{ 	
} 	
public 
ILoggerService 
CreateLogger *
(* +
Type+ /

callerType0 :
): ;
{ 	
return 
NullLoggerService $
.$ %
Instance% -
;- .
} 	
public 
ILoggerService 
CreateLogger *
<* +
TCaller+ 2
>2 3
(3 4
)4 5
{ 	
return 
NullLoggerService $
.$ %
Instance% -
;- .
} 	
} 
} 