ò
mC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Logging\Properties\AssemblyInfo.cs
[ 
assembly 	
:	 

AssemblyTitle 
( 
$str 6
)6 7
]7 8
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
$str 8
)8 9
]9 :
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
]) *©^
cC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Logging\LoggerService.cs
	namespace 	
TrickTakingMissions
 
. 
Logging %
{		 
public 

sealed 
class 
LoggerService %
:& '
ILoggerService( 6
{ 
private 
const 
string #
NamedPlaceholderPattern 4
=5 6
$str7 K
;K L
private 
const 
string 
NullArgumentText -
=. /
$str0 6
;6 7
private 
static 
readonly 
Type  $
DeclaringType% 2
=3 4
typeof5 ;
(; <
LoggerService< I
)I J
;J K
private 
static 
readonly 
Regex  %!
NamedPlaceholderRegex& ;
=< =
new 
Regex 
( #
NamedPlaceholderPattern -
,- .
RegexOptions/ ;
.; <
Compiled< D
)D E
;E F
private 
readonly 
ILog 
_logger %
;% &
public 
LoggerService 
( 
Type !

callerType" ,
), -
{ 	
if 
( 

callerType 
== 
null "
)" #
{ 
throw 
new !
ArgumentNullException /
(/ 0
nameof0 6
(6 7

callerType7 A
)A B
)B C
;C D
} 
_logger 
= 

LogManager  
.  !
	GetLogger! *
(* +

callerType+ 5
)5 6
;6 7
} 	
public   
void   
Trace   
(   
string    
messageTemplate  ! 0
,  0 1
params  2 8
object  9 ?
[  ? @
]  @ A
messageArguments  B R
)  R S
{!! 	
if"" 
("" 
_logger"" 
."" 
Logger"" 
."" 
IsEnabledFor"" +
(""+ ,
Level"", 1
.""1 2
Trace""2 7
)""7 8
)""8 9
{## 
string$$ 
formattedMessage$$ '
=$$( )!
FormatMessageTemplate$$* ?
($$? @
messageTemplate$$@ O
,$$O P
messageArguments$$Q a
)$$a b
;$$b c
_logger%% 
.%% 
Logger%% 
.%% 
Log%% "
(%%" #
DeclaringType%%# 0
,%%0 1
Level%%2 7
.%%7 8
Trace%%8 =
,%%= >
formattedMessage%%? O
,%%O P
null%%Q U
)%%U V
;%%V W
}&& 
}'' 	
public)) 
void)) 
Debug)) 
()) 
string))  
messageTemplate))! 0
,))0 1
params))2 8
object))9 ?
[))? @
]))@ A
messageArguments))B R
)))R S
{** 	
if++ 
(++ 
_logger++ 
.++ 
IsDebugEnabled++ &
)++& '
{,, 
string-- 
formattedMessage-- '
=--( )!
FormatMessageTemplate--* ?
(--? @
messageTemplate--@ O
,--O P
messageArguments--Q a
)--a b
;--b c
_logger.. 
... 
Debug.. 
(.. 
formattedMessage.. .
)... /
;../ 0
}// 
}00 	
public22 
void22 
Information22 
(22  
string22  &
messageTemplate22' 6
,226 7
params228 >
object22? E
[22E F
]22F G
messageArguments22H X
)22X Y
{33 	
if44 
(44 
_logger44 
.44 
IsInfoEnabled44 %
)44% &
{55 
string66 
formattedMessage66 '
=66( )!
FormatMessageTemplate66* ?
(66? @
messageTemplate66@ O
,66O P
messageArguments66Q a
)66a b
;66b c
_logger77 
.77 
Info77 
(77 
formattedMessage77 -
)77- .
;77. /
}88 
}99 	
public;; 
void;; 
Warning;; 
(;; 
string;; "
messageTemplate;;# 2
,;;2 3
params;;4 :
object;;; A
[;;A B
];;B C
messageArguments;;D T
);;T U
{<< 	
if== 
(== 
_logger== 
.== 
IsWarnEnabled== %
)==% &
{>> 
string?? 
formattedMessage?? '
=??( )!
FormatMessageTemplate??* ?
(??? @
messageTemplate??@ O
,??O P
messageArguments??Q a
)??a b
;??b c
_logger@@ 
.@@ 
Warn@@ 
(@@ 
formattedMessage@@ -
)@@- .
;@@. /
}AA 
}BB 	
publicDD 
voidDD 
ErrorDD 
(DD 
stringDD  
messageTemplateDD! 0
,DD0 1
paramsDD2 8
objectDD9 ?
[DD? @
]DD@ A
messageArgumentsDDB R
)DDR S
{EE 	
ifFF 
(FF 
_loggerFF 
.FF 
IsErrorEnabledFF &
)FF& '
{GG 
stringHH 
formattedMessageHH '
=HH( )!
FormatMessageTemplateHH* ?
(HH? @
messageTemplateHH@ O
,HHO P
messageArgumentsHHQ a
)HHa b
;HHb c
_loggerII 
.II 
ErrorII 
(II 
formattedMessageII .
)II. /
;II/ 0
}JJ 
}KK 	
publicMM 
voidMM 
ErrorMM 
(MM 
	ExceptionMM #
	exceptionMM$ -
,MM- .
stringMM/ 5
messageTemplateMM6 E
,MME F
paramsMMG M
objectMMN T
[MMT U
]MMU V
messageArgumentsMMW g
)MMg h
{NN 	
ifOO 
(OO 
_loggerOO 
.OO 
IsErrorEnabledOO &
)OO& '
{PP 
stringQQ 
formattedMessageQQ '
=QQ( )!
FormatMessageTemplateQQ* ?
(QQ? @
messageTemplateQQ@ O
,QQO P
messageArgumentsQQQ a
)QQa b
;QQb c
_loggerRR 
.RR 
ErrorRR 
(RR 
formattedMessageRR .
,RR. /
	exceptionRR0 9
)RR9 :
;RR: ;
}SS 
}TT 	
publicVV 
voidVV 
FatalVV 
(VV 
stringVV  
messageTemplateVV! 0
,VV0 1
paramsVV2 8
objectVV9 ?
[VV? @
]VV@ A
messageArgumentsVVB R
)VVR S
{WW 	
ifXX 
(XX 
_loggerXX 
.XX 
IsFatalEnabledXX &
)XX& '
{YY 
stringZZ 
formattedMessageZZ '
=ZZ( )!
FormatMessageTemplateZZ* ?
(ZZ? @
messageTemplateZZ@ O
,ZZO P
messageArgumentsZZQ a
)ZZa b
;ZZb c
_logger[[ 
.[[ 
Fatal[[ 
([[ 
formattedMessage[[ .
)[[. /
;[[/ 0
}\\ 
}]] 	
public__ 
void__ 
Fatal__ 
(__ 
	Exception__ #
	exception__$ -
,__- .
string__/ 5
messageTemplate__6 E
,__E F
params__G M
object__N T
[__T U
]__U V
messageArguments__W g
)__g h
{`` 	
ifaa 
(aa 
_loggeraa 
.aa 
IsFatalEnabledaa &
)aa& '
{bb 
stringcc 
formattedMessagecc '
=cc( )!
FormatMessageTemplatecc* ?
(cc? @
messageTemplatecc@ O
,ccO P
messageArgumentsccQ a
)cca b
;ccb c
_loggerdd 
.dd 
Fataldd 
(dd 
formattedMessagedd .
,dd. /
	exceptiondd0 9
)dd9 :
;dd: ;
}ee 
}ff 	
privatehh 
statichh 
stringhh !
FormatMessageTemplatehh 3
(hh3 4
stringhh4 :
messageTemplatehh; J
,hhJ K
objecthhL R
[hhR S
]hhS T
messageArgumentshhU e
)hhe f
{ii 	
stringjj 
formattedMessagejj #
=jj$ %
messageTemplatejj& 5
??jj6 8
stringjj9 ?
.jj? @
Emptyjj@ E
;jjE F
ifll 
(ll 
!ll 
stringll 
.ll 
IsNullOrEmptyll %
(ll% &
formattedMessagell& 6
)ll6 7
&&ll8 :
messageArgumentsll; K
!=llL N
nullllO S
&&llT V
messageArgumentsllW g
.llg h
Lengthllh n
>llo p
$numllq r
)llr s
{mm 
StringBuildernn 
messageBuildernn ,
=nn- .
newnn/ 2
StringBuildernn3 @
(nn@ A
formattedMessagennA Q
.nnQ R
LengthnnR X
)nnX Y
;nnY Z
MatchCollectionoo 
placeholderMatchesoo  2
=oo3 4!
NamedPlaceholderRegexoo5 J
.ooJ K
MatchesooK R
(ooR S
formattedMessageooS c
)ooc d
;ood e
intpp 
currentTextPositionpp '
=pp( )
$numpp* +
;pp+ ,
intqq 
argumentIndexqq !
=qq" #
$numqq$ %
;qq% &
foreachss 
(ss 
Matchss 
placeholderMatchss /
inss0 2
placeholderMatchesss3 E
)ssE F
{tt 
ifuu 
(uu 
argumentIndexuu %
<uu& '
messageArgumentsuu( 8
.uu8 9
Lengthuu9 ?
)uu? @
{vv 
messageBuilderww &
.ww& '
Appendww' -
(ww- .
formattedMessageww. >
,ww> ?
currentTextPositionww@ S
,wwS T
placeholderMatchxx ,
.xx, -
Indexxx- 2
-xx3 4
currentTextPositionxx5 H
)xxH I
;xxI J
stringyy 
argumentTextyy +
=yy, -
messageArgumentsyy. >
[yy> ?
argumentIndexyy? L
]yyL M
?yyM N
.yyN O
ToStringyyO W
(yyW X
)yyX Y
??yyZ \
NullArgumentTextyy] m
;yym n
messageBuilder{{ &
.{{& '
Append{{' -
({{- .
argumentText{{. :
){{: ;
;{{; <
currentTextPosition|| +
=||, -
placeholderMatch||. >
.||> ?
Index||? D
+||E F
placeholderMatch||G W
.||W X
Length||X ^
;||^ _
argumentIndex}} %
++}}% '
;}}' (
}~~ 
} 
messageBuilder
ÅÅ 
.
ÅÅ 
Append
ÅÅ %
(
ÅÅ% &
formattedMessage
ÅÅ& 6
,
ÅÅ6 7!
currentTextPosition
ÅÅ8 K
,
ÅÅK L
formattedMessage
ÇÇ $
.
ÇÇ$ %
Length
ÇÇ% +
-
ÇÇ, -!
currentTextPosition
ÇÇ. A
)
ÇÇA B
;
ÇÇB C
formattedMessage
ÉÉ  
=
ÉÉ! "
messageBuilder
ÉÉ# 1
.
ÉÉ1 2
ToString
ÉÉ2 :
(
ÉÉ: ;
)
ÉÉ; <
;
ÉÉ< =
}
ÑÑ 
return
ÜÜ 
formattedMessage
ÜÜ #
;
ÜÜ# $
}
áá 	
}
àà 
}ââ ö
cC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Logging\LoggerFactory.cs
	namespace 	
TrickTakingMissions
 
. 
Logging %
{ 
public 

sealed 
class 
LoggerFactory %
:& '
ILoggerFactory( 6
{ 
public		 
ILoggerService		 
CreateLogger		 *
(		* +
Type		+ /

callerType		0 :
)		: ;
{

 	
return 
new 
LoggerService $
($ %

callerType% /
)/ 0
;0 1
} 	
public 
ILoggerService 
CreateLogger *
<* +
TCaller+ 2
>2 3
(3 4
)4 5
{ 	
return 
new 
LoggerService $
($ %
typeof% +
(+ ,
TCaller, 3
)3 4
)4 5
;5 6
} 	
} 
} ¶1
iC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Logging\Log4NetConfigurator.cs
	namespace

 	
TrickTakingMissions


 
.

 
Logging

 %
{ 
public 

static 
class 
Log4NetConfigurator +
{ 
private 
const 
string #
RollingFileAppenderName 4
=5 6
$str7 L
;L M
private 
const 
string !
ConversionPatternText 2
=3 4
$str d
;d e
private 
const 
string "
RollingDatePatternText 3
=4 5
$str6 I
;I J
private 
const 
string 
MaximumFileSizeText 0
=1 2
$str3 9
;9 :
private 
const 
string !
EmptyDirectoryMessage 2
=3 4
$str5 e
;e f
private 
const 
string  
EmptyFileNameMessage 1
=2 3
$str4 c
;c d
private 
const 
int #
MaximumRollBackupsCount 1
=2 3
$num4 6
;6 7
public 
static 
void 
	Configure $
($ %
string% +
logsDirectory, 9
,9 :
string; A
logFileNameB M
)M N
{ 	%
ConfigureWithMinimumLevel %
(% &
logsDirectory& 3
,3 4
logFileName5 @
,@ A
LevelB G
.G H
InfoH L
)L M
;M N
} 	
public 
static 
void %
ConfigureWithMinimumLevel 4
(4 5
string5 ;
logsDirectory< I
,I J
stringK Q
logFileNameR ]
,] ^
Level_ d
minimumLevele q
)q r
{ 	
if 
( 
string 
. 
IsNullOrWhiteSpace )
() *
logsDirectory* 7
)7 8
)8 9
{   
throw!! 
new!! 
ArgumentException!! +
(!!+ ,!
EmptyDirectoryMessage!!, A
,!!A B
nameof!!C I
(!!I J
logsDirectory!!J W
)!!W X
)!!X Y
;!!Y Z
}"" 
if$$ 
($$ 
string$$ 
.$$ 
IsNullOrWhiteSpace$$ )
($$) *
logFileName$$* 5
)$$5 6
)$$6 7
{%% 
throw&& 
new&& 
ArgumentException&& +
(&&+ , 
EmptyFileNameMessage&&, @
,&&@ A
nameof&&B H
(&&H I
logFileName&&I T
)&&T U
)&&U V
;&&V W
}'' 
if)) 
()) 
minimumLevel)) 
==)) 
null))  $
)))$ %
{** 
throw++ 
new++ !
ArgumentNullException++ /
(++/ 0
nameof++0 6
(++6 7
minimumLevel++7 C
)++C D
)++D E
;++E F
},, 
	Hierarchy.. 
repositoryHierarchy.. )
=..* +
(.., -
	Hierarchy..- 6
)..6 7

LogManager..7 A
...A B
GetRepository..B O
(..O P
)..P Q
;..Q R
if00 
(00 
!00 
repositoryHierarchy00 $
.00$ %

Configured00% /
)00/ 0
{11 
	Directory22 
.22 
CreateDirectory22 )
(22) *
logsDirectory22* 7
)227 8
;228 9
PatternLayout44 
patternLayout44 +
=44, -
new44. 1
PatternLayout442 ?
{55 
ConversionPattern66 %
=66& '!
ConversionPatternText66( =
}77 
;77 
patternLayout88 
.88 
ActivateOptions88 -
(88- .
)88. /
;88/ 0
string:: 
logFilePath:: "
=::# $
Path::% )
.::) *
Combine::* 1
(::1 2
logsDirectory::2 ?
,::? @
logFileName::A L
)::L M
;::M N
RollingFileAppender;; #
rollingFileAppender;;$ 7
=;;8 9
new;;: =
RollingFileAppender;;> Q
{<< 
Name== 
=== #
RollingFileAppenderName== 2
,==2 3
File>> 
=>> 
logFilePath>> &
,>>& '
AppendToFile??  
=??! "
true??# '
,??' (
RollingStyle@@  
=@@! "
RollingFileAppender@@# 6
.@@6 7
RollingMode@@7 B
.@@B C
	Composite@@C L
,@@L M
DatePatternAA 
=AA  !"
RollingDatePatternTextAA" 8
,AA8 9
MaxSizeRollBackupsBB &
=BB' (#
MaximumRollBackupsCountBB) @
,BB@ A
MaximumFileSizeCC #
=CC$ %
MaximumFileSizeTextCC& 9
,CC9 :
StaticLogFileNameDD %
=DD& '
trueDD( ,
,DD, -
EncodingEE 
=EE 
EncodingEE '
.EE' (
UTF8EE( ,
,EE, -
LockingModelFF  
=FF! "
newFF# &
FileAppenderFF' 3
.FF3 4
MinimalLockFF4 ?
(FF? @
)FF@ A
,FFA B
LayoutGG 
=GG 
patternLayoutGG *
}HH 
;HH 
rollingFileAppenderII #
.II# $
ActivateOptionsII$ 3
(II3 4
)II4 5
;II5 6
repositoryHierarchyKK #
.KK# $
RootKK$ (
.KK( )
AddAppenderKK) 4
(KK4 5
rollingFileAppenderKK5 H
)KKH I
;KKI J
repositoryHierarchyLL #
.LL# $
RootLL$ (
.LL( )
LevelLL) .
=LL/ 0
minimumLevelLL1 =
;LL= >
repositoryHierarchyMM #
.MM# $

ConfiguredMM$ .
=MM/ 0
trueMM1 5
;MM5 6
}NN 
}OO 	
}PP 
}QQ 