“
RC:\Users\oscar\source\repos\TrickTakingMissions\Server\Host\LobbyHostingContext.cs
	namespace 	
Host
 
{ 
internal 
sealed 
class 
LobbyHostingContext -
{ 
public		 
IUserRepository		 
UserRepository		 -
{		. /
get		0 3
;		3 4
set		5 8
;		8 9
}		: ;
public

 $
ILobbyChatMessageUseCase

 '
ChatMessageUseCase

( :
{

; <
get

= @
;

@ A
set

B E
;

E F
}

G H
public  
IAccountAccessPolicy #
AccountAccessPolicy$ 7
{8 9
get: =
;= >
set? B
;B C
}D E
public 
ILoggerFactory 
LoggerFactory +
{, -
get. 1
;1 2
set3 6
;6 7
}8 9
} 
} ﬁ`
bC:\Users\oscar\source\repos\TrickTakingMissions\Server\Host\Gameplay\MissionTransitionScheduler.cs
	namespace

 	
Host


 
.

 
Gameplay

 
{ 
internal 
sealed 
class &
MissionTransitionScheduler 4
:5 6
IDisposable7 B
{ 
private 
const 
int $
ShutdownWaitMilliseconds 2
=3 4
$num5 9
;9 :
private 
const 
string (
ScheduledWorkerFaultTemplate 9
=: ;
$str N
;N O
private 
readonly 
IMatchUseCase &
_matchUseCase' 4
;4 5
private 
readonly &
IMatchStateChangePublisher 3

_publisher4 >
;> ?
private 
readonly 
ILoggerService '
_logger( /
;/ 0
private 
readonly #
CancellationTokenSource 0
	_shutdown1 :
=; <
new= @#
CancellationTokenSourceA X
(X Y
)Y Z
;Z [
private 
readonly  
ConcurrentDictionary -
<- .
Guid. 2
,2 3
Task4 8
>8 9
_workers: B
=C D
newE H 
ConcurrentDictionaryI ]
<] ^
Guid^ b
,b c
Taskd h
>h i
(i j
)j k
;k l
private 
Timer 
_timer 
; 
private 
int 
_isScanning 
;  
private 
int 
_isDisposed 
;  
public &
MissionTransitionScheduler )
() *
IMatchUseCase* 7
matchUseCase8 D
,D E&
IMatchStateChangePublisherF `
	publishera j
,j k
ILoggerService 
logger !
)! "
{ 	
_matchUseCase 
= 
matchUseCase (
??) +
throw, 1
new2 5!
ArgumentNullException6 K
(K L
nameofL R
(R S
matchUseCaseS _
)_ `
)` a
;a b

_publisher 
= 
	publisher "
??# %
throw& +
new, /!
ArgumentNullException0 E
(E F
nameofF L
(L M
	publisherM V
)V W
)W X
;X Y
_logger   
=   
logger   
??   
throw    %
new  & )!
ArgumentNullException  * ?
(  ? @
nameof  @ F
(  F G
logger  G M
)  M N
)  N O
;  O P
}!! 	
public## 
void## 
OnHostOpened##  
(##  !
object##! '
sender##( .
,##. /
	EventArgs##0 9
	eventArgs##: C
)##C D
{$$ 	
_timer%% 
=%% 
new%% 
Timer%% 
(%% 
OnTimerTick%% *
,%%* +
null%%, 0
,%%0 1
$num%%2 3
,%%3 4#
MissionTransitionPolicy%%5 L
.%%L M)
SchedulerIntervalMilliseconds%%M j
)%%j k
;%%k l
}&& 	
public(( 
void(( 
OnHostStopped(( !
(((! "
object((" (
sender(() /
,((/ 0
	EventArgs((1 :
	eventArgs((; D
)((D E
{)) 	
Dispose** 
(** 
)** 
;** 
}++ 	
private-- 
void-- 
OnTimerTick--  
(--  !
object--! '
state--( -
)--- .
{.. 	
if// 
(// 
!// 
	_shutdown// 
.// #
IsCancellationRequested// 2
&&//3 5
Interlocked//6 A
.//A B
CompareExchange//B Q
(//Q R
ref//R U
_isScanning//V a
,//a b
$num//c d
,//d e
$num//f g
)//g h
==//i k
$num//l m
)//m n
{00 
Task11 
scan11 
=11 
Task11  
.11  !
Run11! $
(11$ %
ScanDueTransitions11% 7
)117 8
;118 9
scan22 
.22 
ContinueWith22 !
(22! "
OnScanCompleted22" 1
,221 2
TaskScheduler223 @
.22@ A
Default22A H
)22H I
;22I J
}33 
}44 	
private66 
void66 
ScanDueTransitions66 '
(66' (
)66( )
{77 	
try88 
{99 
int:: 
availableWorkers:: $
=::% &#
MissionTransitionPolicy::' >
.::> ?)
MaximumConcurrentPreparations::? \
-::] ^
_workers::_ g
.::g h
Count::h m
;::m n
foreach;; 
(;; !
MissionTransitionWork;; .
transitionWork;;/ =
in;;> @
_matchUseCase<< !
.<<! "%
TakeDueMissionTransitions<<" ;
(<<; <
availableWorkers<<< L
)<<L M
)<<M N
{== 
StartWorker>> 
(>>  
transitionWork>>  .
)>>. /
;>>/ 0
}?? 
}@@ 
finallyAA 
{BB 
InterlockedCC 
.CC 
ExchangeCC $
(CC$ %
refCC% (
_isScanningCC) 4
,CC4 5
$numCC6 7
)CC7 8
;CC8 9
}DD 
}EE 	
privateGG 
voidGG 
OnScanCompletedGG $
(GG$ %
TaskGG% )
scanGG* .
)GG. /
{HH 	
ifII 
(II 
scanII 
.II 
	IsFaultedII 
)II 
{JJ 
_loggerKK 
.KK 
ErrorKK 
(KK (
ScheduledWorkerFaultTemplateKK :
,KK: ;
scanKK< @
.KK@ A
	ExceptionKKA J
.KKJ K
GetBaseExceptionKKK [
(KK[ \
)KK\ ]
.KK] ^
GetTypeKK^ e
(KKe f
)KKf g
.KKg h
NameKKh l
)KKl m
;KKm n
}LL 
}MM 	
privateOO 
voidOO 
StartWorkerOO  
(OO  !!
MissionTransitionWorkOO! 6
transitionWorkOO7 E
)OOE F
{PP 	
ifQQ 
(QQ 
	_shutdownQQ 
.QQ #
IsCancellationRequestedQQ 1
)QQ1 2
{RR 
_matchUseCaseSS 
.SS /
#ReleaseMissionTransitionReservationSS A
(SSA B
transitionWorkSSB P
,SSP Q
falseSSR W
)SSW X
;SSX Y
}TT 
varUU 
workerUU 
=UU 
newUU 
TaskUU !
(UU! "
(UU" #
)UU# $
=>UU% '
ExecuteWorkerUU( 5
(UU5 6
transitionWorkUU6 D
)UUD E
)UUE F
;UUF G
ifVV 
(VV 
_workersVV 
.VV 
TryAddVV 
(VV  
transitionWorkVV  .
.VV. /'
MissionTransitionScheduleIdVV/ J
,VVJ K
workerVVL R
)VVR S
)VVS T
{WW 
workerXX 
.XX 
ContinueWithXX #
(XX# $
	completedXX$ -
=>XX. 0
OnWorkerCompletedXX1 B
(XXB C
	completedXXC L
,XXL M
transitionWorkXXN \
)XX\ ]
,XX] ^
TaskSchedulerXX_ l
.XXl m
DefaultXXm t
)XXt u
;XXu v
workerYY 
.YY 
StartYY 
(YY 
TaskSchedulerYY *
.YY* +
DefaultYY+ 2
)YY2 3
;YY3 4
}ZZ 
}[[ 	
private]] 
void]] 
ExecuteWorker]] "
(]]" #!
MissionTransitionWork]]# 8
transitionWork]]9 G
)]]G H
{^^ 	,
 MissionTransitionExecutionResult__ ,
result__- 3
=__4 5
_matchUseCase`` 
.`` -
!ExecuteScheduledMissionTransition`` ?
(``? @
transitionWork``@ N
,``N O
	_shutdown``P Y
.``Y Z
Token``Z _
)``_ `
;``` a
ifaa 
(aa 
resultaa 
.aa 
HasStateChangedaa &
&&aa' )
!aa* +
	_shutdownaa+ 4
.aa4 5#
IsCancellationRequestedaa5 L
)aaL M
{bb 

_publishercc 
.cc #
PublishMatchStateChangecc 2
(cc2 3
resultcc3 9
.cc9 :
	LobbyCodecc: C
,ccC D
resultccE K
.ccK L&
CommittedMatchStateVersionccL f
)ccf g
;ccg h
}dd 
}ee 	
privategg 
voidgg 
OnWorkerCompletedgg &
(gg& '
Taskgg' +
workergg, 2
,gg2 3!
MissionTransitionWorkgg4 I
transitionWorkggJ X
)ggX Y
{hh 	
tryii 
{jj 
ifkk 
(kk 
workerkk 
.kk 
	IsFaultedkk $
)kk$ %
{ll 
_loggermm 
.mm 
Errormm !
(mm! "(
ScheduledWorkerFaultTemplatemm" >
,mm> ?
workermm@ F
.mmF G
	ExceptionmmG P
.mmP Q
GetBaseExceptionmmQ a
(mma b
)mmb c
.mmc d
GetTypemmd k
(mmk l
)mml m
.mmm n
Namemmn r
)mmr s
;mms t
_matchUseCasenn !
.nn! "/
#ReleaseMissionTransitionReservationnn" E
(nnE F
transitionWorknnF T
,nnT U
truennV Z
)nnZ [
;nn[ \
}oo 
elsepp 
ifpp 
(pp 
workerpp 
.pp  

IsCanceledpp  *
||pp+ -
	_shutdownpp. 7
.pp7 8#
IsCancellationRequestedpp8 O
)ppO P
{qq 
_matchUseCaserr !
.rr! "/
#ReleaseMissionTransitionReservationrr" E
(rrE F
transitionWorkrrF T
,rrT U
falserrV [
)rr[ \
;rr\ ]
}ss 
}tt 
finallyuu 
{vv 
_workersww 
.ww 
	TryRemoveww "
(ww" #
transitionWorkww# 1
.ww1 2'
MissionTransitionScheduleIdww2 M
,wwM N
outwwO R
TaskwwS W
_wwX Y
)wwY Z
;wwZ [
}xx 
}yy 	
public{{ 
void{{ 
Dispose{{ 
({{ 
){{ 
{|| 	
if}} 
(}} 
Interlocked}} 
.}} 
Exchange}} $
(}}$ %
ref}}% (
_isDisposed}}) 4
,}}4 5
$num}}6 7
)}}7 8
==}}9 ;
$num}}< =
)}}= >
{~~ 
	_shutdown 
. 
Cancel  
(  !
)! "
;" #
_timer
ÄÄ 
?
ÄÄ 
.
ÄÄ 
Dispose
ÄÄ 
(
ÄÄ  
)
ÄÄ  !
;
ÄÄ! "
try
ÅÅ 
{
ÇÇ 
Task
ÉÉ 
.
ÉÉ 
WaitAll
ÉÉ  
(
ÉÉ  !
_workers
ÉÉ! )
.
ÉÉ) *
Values
ÉÉ* 0
.
ÉÉ0 1
ToArray
ÉÉ1 8
(
ÉÉ8 9
)
ÉÉ9 :
,
ÉÉ: ;&
ShutdownWaitMilliseconds
ÉÉ< T
)
ÉÉT U
;
ÉÉU V
}
ÑÑ 
catch
ÖÖ 
(
ÖÖ  
AggregateException
ÖÖ )
ex
ÖÖ* ,
)
ÖÖ, -
{
ÜÜ 
_logger
áá 
.
áá 
Warning
áá #
(
áá# $*
ScheduledWorkerFaultTemplate
áá$ @
,
áá@ A
ex
ááB D
.
ááD E
GetBaseException
ááE U
(
ááU V
)
ááV W
.
ááW X
GetType
ááX _
(
áá_ `
)
áá` a
.
ááa b
Name
ááb f
)
ááf g
;
áág h
}
àà 
}
ââ 
}
ää 	
}
ãã 
}åå º
[C:\Users\oscar\source\repos\TrickTakingMissions\Server\Host\Gameplay\MonotonicMatchClock.cs
	namespace 	
Host
 
. 
Gameplay 
{ 
internal 
sealed 
class 
MonotonicMatchClock -
:. /
IMatchClock0 ;
{ 
private		 
readonly		 
	Stopwatch		 "
_elapsedServerTime		# 5
=		6 7
	Stopwatch		8 A
.		A B
StartNew		B J
(		J K
)		K L
;		L M
public 
long $
GetTimestampMilliseconds ,
(, -
)- .
{ 	
return 
_elapsedServerTime %
.% &
ElapsedMilliseconds& 9
;9 :
} 	
} 
} £4
_C:\Users\oscar\source\repos\TrickTakingMissions\Server\Host\Gameplay\SecureMissionDeckDealer.cs
	namespace

 	
Host


 
.

 
Gameplay

 
{ 
internal 
sealed 
class #
SecureMissionDeckDealer 1
:2 3
IMissionDeckDealer4 F
{ 
private 
const 
int ,
 ThreePlayerMatchParticipantCount :
=; <
$num= >
;> ?
public 
MissionDeal 
CreateMissionDeal ,
(, -
int- 0
participantCount1 A
)A B
{ 	
var 
shuffledCards 
= 
new  #
List$ (
<( )
Card) -
>- .
(. /
	DeckRules/ 8
.8 9
CreateStandardDeck9 K
(K L
)L M
)M N
;N O
int )
firstSpecialCardReceivingSeat -
=. /
$num0 1
;1 2
using 
( !
RandomNumberGenerator (
randomGenerator) 8
=9 :!
RandomNumberGenerator; P
.P Q
CreateQ W
(W X
)X Y
)Y Z
{ 
if 
( 
participantCount $
==% ',
 ThreePlayerMatchParticipantCount( H
)H I
{ )
firstSpecialCardReceivingSeat 1
=2 3
GetUnbiasedIndex4 D
(D E
randomGeneratorE T
,T U
participantCountV f
)f g
;g h
} 
ShuffleCards 
( 
shuffledCards *
,* +
randomGenerator, ;
); <
;< =
} 
return 
DeckDealRules  
.  !
	DealCards! *
(* +
shuffledCards+ 8
.8 9

AsReadOnly9 C
(C D
)D E
,E F
participantCountG W
,W X)
firstSpecialCardReceivingSeatY v
)v w
;w x
} 	
public   
IReadOnlyList   
<   
MissionObjective   -
>  - .#
CreateMissionObjectives  / F
(  F G
MissionDefinition  G X

definition  Y c
)  c d
{!! 	
var"" 
shuffledCards"" 
="" 
new""  #
List""$ (
<""( )
Card"") -
>""- .
("". /
	DeckRules""/ 8
.""8 9
CreateStandardDeck""9 K
(""K L
)""L M
)""M N
;""N O
using## 
(## !
RandomNumberGenerator## (
randomGenerator##) 8
=##9 :!
RandomNumberGenerator##; P
.##P Q
Create##Q W
(##W X
)##X Y
)##Y Z
{$$ 
ShuffleCards%% 
(%% 
shuffledCards%% *
,%%* +
randomGenerator%%, ;
)%%; <
;%%< =
}&& 
return'' %
MissionObjectiveDealRules'' ,
.'', -
CreateObjectives''- =
(''= >

definition''> H
,''H I
shuffledCards(( 
.(( 
FindAll(( %
(((% &
card((& *
=>((+ -
card((. 2
.((2 3
Suit((3 7
!=((8 :
CardSuit((; C
.((C D
Special((D K
)((K L
.((L M

ConvertAll((M W
(((W X
card((X \
=>((] _
card((` d
.((d e
IdCard((e k
)((k l
)((l m
;((m n
})) 	
private++ 
static++ 
void++ 
ShuffleCards++ (
(++( )
List++) -
<++- .
Card++. 2
>++2 3
shuffledCards++4 A
,++A B!
RandomNumberGenerator++C X
randomGenerator++Y h
)++h i
{,, 	
for-- 
(-- 
int-- 
	cardIndex-- 
=--  
shuffledCards--! .
.--. /
Count--/ 4
---5 6
$num--7 8
;--8 9
	cardIndex--: C
>--D E
$num--F G
;--G H
	cardIndex--I R
----R T
)--T U
{.. 
int// 
	swapIndex// 
=// 
GetUnbiasedIndex//  0
(//0 1
randomGenerator//1 @
,//@ A
	cardIndex//B K
+//L M
$num//N O
)//O P
;//P Q
Card00 
displacedCard00 "
=00# $
shuffledCards00% 2
[002 3
	cardIndex003 <
]00< =
;00= >
shuffledCards11 
[11 
	cardIndex11 '
]11' (
=11) *
shuffledCards11+ 8
[118 9
	swapIndex119 B
]11B C
;11C D
shuffledCards22 
[22 
	swapIndex22 '
]22' (
=22) *
displacedCard22+ 8
;228 9
}33 
}44 	
private66 
static66 
int66 
GetUnbiasedIndex66 +
(66+ ,!
RandomNumberGenerator66, A
randomGenerator66B Q
,66Q R
int66S V
exclusiveMaximum66W g
)66g h
{77 	
var88 
randomBytes88 
=88 
new88 !
byte88" &
[88& '
sizeof88' -
(88- .
uint88. 2
)882 3
]883 4
;884 5
uint99 
randomValue99 
;99 
uint:: 
acceptedLimit:: 
=::  
uint::! %
.::% &
MaxValue::& .
-::/ 0
(::1 2
uint::2 6
.::6 7
MaxValue::7 ?
%::@ A
(::B C
uint::C G
)::G H
exclusiveMaximum::H X
)::X Y
;::Y Z
do;; 
{<< 
randomGenerator== 
.==  
GetBytes==  (
(==( )
randomBytes==) 4
)==4 5
;==5 6
randomValue>> 
=>> 
BitConverter>> *
.>>* +
ToUInt32>>+ 3
(>>3 4
randomBytes>>4 ?
,>>? @
$num>>A B
)>>B C
;>>C D
}?? 
while@@ 
(@@ 
randomValue@@ 
>=@@ !
acceptedLimit@@" /
)@@/ 0
;@@0 1
returnAA 
(AA 
intAA 
)AA 
(AA 
randomValueAA $
%AA% &
exclusiveMaximumAA' 7
)AA7 8
;AA8 9
}BB 	
}CC 
}DD •
_C:\Users\oscar\source\repos\TrickTakingMissions\Server\Host\Gameplay\InMemoryMatchStateStore.cs
	namespace 	
Host
 
. 
Gameplay 
{ 
internal

 
sealed

 
class

 #
InMemoryMatchStateStore

 1
:

2 3
IMatchStateStore

4 D
{ 
private 
const 
int "
MaximumRetainedMatches 0
=1 2
$num3 6
;6 7
private 
readonly 

Dictionary #
<# $
string$ *
,* +

MatchState, 6
>6 7
_matchesByLobbyCode8 K
=L M
new 

Dictionary 
< 
string !
,! "

MatchState# -
>- .
(. /
StringComparer/ =
.= >
OrdinalIgnoreCase> O
)O P
;P Q
public 

MatchState 
GetOrCreateMatch *
(* +
string+ 1
	lobbyCode2 ;
,; <
Func= A
<A B

MatchStateB L
>L M
createMatchN Y
)Y Z
{ 	

MatchState 

matchState !
;! "
lock 
( 
_matchesByLobbyCode %
)% &
{ 
if 
( 
! 
_matchesByLobbyCode (
.( )
TryGetValue) 4
(4 5
	lobbyCode5 >
,> ?
out@ C

matchStateD N
)N O
)O P
{ 
if 
( 
_matchesByLobbyCode +
.+ ,
Count, 1
>=2 4"
MaximumRetainedMatches5 K
)K L
{ 
throw 
new !%
InvalidOperationException" ;
(; <
$str< R
)R S
;S T
} 

matchState 
=  
createMatch! ,
(, -
)- .
;. /
_matchesByLobbyCode '
.' (
Add( +
(+ ,
	lobbyCode, 5
,5 6

matchState7 A
)A B
;B C
} 
} 
return 

matchState 
; 
}   	
public"" 
IReadOnlyList"" 
<"" 
KeyValuePair"" )
<"") *
string""* 0
,""0 1

MatchState""2 <
>""< =
>""= >

GetMatches""? I
(""I J
)""J K
{## 	
KeyValuePair$$ 
<$$ 
string$$ 
,$$  

MatchState$$! +
>$$+ ,
[$$, -
]$$- .
matches$$/ 6
;$$6 7
lock%% 
(%% 
_matchesByLobbyCode%% %
)%%% &
{&& 
matches'' 
='' 
_matchesByLobbyCode'' -
.''- .
ToArray''. 5
(''5 6
)''6 7
;''7 8
}(( 
return)) 
matches)) 
;)) 
}** 	
public,, 

MatchState,, 
	FindMatch,, #
(,,# $
string,,$ *
	lobbyCode,,+ 4
),,4 5
{-- 	

MatchState.. 

matchState.. !
;..! "
lock// 
(// 
_matchesByLobbyCode// %
)//% &
{00 
_matchesByLobbyCode11 #
.11# $
TryGetValue11$ /
(11/ 0
	lobbyCode110 9
,119 :
out11; >

matchState11? I
)11I J
;11J K
}22 
return33 

matchState33 
;33 
}44 	
}55 
}66 Å
VC:\Users\oscar\source\repos\TrickTakingMissions\Server\Host\Properties\AssemblyInfo.cs
[ 
assembly 	
:	 

AssemblyTitle 
( 
$str 
)  
]  !
[		 
assembly		 	
:			 

AssemblyDescription		 
(		 
$str		 !
)		! "
]		" #
[

 
assembly

 	
:

	 
!
AssemblyConfiguration

  
(

  !
$str

! #
)

# $
]

$ %
[ 
assembly 	
:	 

AssemblyCompany 
( 
$str 
) 
] 
[ 
assembly 	
:	 

AssemblyProduct 
( 
$str !
)! "
]" #
[ 
assembly 	
:	 

AssemblyCopyright 
( 
$str 0
)0 1
]1 2
[ 
assembly 	
:	 

AssemblyTrademark 
( 
$str 
)  
]  !
[ 
assembly 	
:	 

AssemblyCulture 
( 
$str 
) 
] 
[ 
assembly 	
:	 


ComVisible 
( 
false 
) 
] 
[ 
assembly 	
:	 

Guid 
( 
$str 6
)6 7
]7 8
[   
assembly   	
:  	 

AssemblyVersion   
(   
$str   $
)  $ %
]  % &
[!! 
assembly!! 	
:!!	 

AssemblyFileVersion!! 
(!! 
$str!! (
)!!( )
]!!) *≈*
RC:\Users\oscar\source\repos\TrickTakingMissions\Server\Host\ProfileImageHosting.cs
	namespace 	
Host
 
{ 
internal 
static 
class 
ProfileImageHosting -
{ 
internal 
static 
ServiceHost #
Create$ *
(* + 
IAccountAccessPolicy+ ?
accountAccessPolicy@ S
,S T
ILoggerFactoryU c
loggerFactoryd q
)q r
{ 	
string 
storageDirectory #
=$ % 
ConfigurationManager& :
.: ;
AppSettings; F
[F G
$strG _
]_ `
;` a
if 
( 
string 
. 
IsNullOrWhiteSpace )
() *
storageDirectory* :
): ;
); <
{ 
storageDirectory  
=! "
Path# '
.' (
Combine( /
(/ 0
Environment 
.  
GetFolderPath  -
(- .
Environment. 9
.9 :
SpecialFolder: G
.G H 
LocalApplicationDataH \
)\ ]
,] ^
$str #
,# $
$str% -
,- .
$str/ >
)> ?
;? @
} 
var 
useCase 
= 
new 
ProfileImageUseCase 1
(1 2
new !
ProfileImageProcessor )
() *
)* +
,+ ,
new   #
FileProfileImageStorage   +
(  + ,
storageDirectory  , <
,  < =
loggerFactory  > K
.  K L
CreateLogger  L X
<  X Y#
FileProfileImageStorage  Y p
>  p q
(  q r
)  r s
)  s t
,  t u
new!! #
PlayerProfileRepository!! +
(!!+ ,
loggerFactory!!, 9
.!!9 :
CreateLogger!!: F
<!!F G#
PlayerProfileRepository!!G ^
>!!^ _
(!!_ `
)!!` a
)!!a b
,!!b c
loggerFactory"" 
."" 
CreateLogger"" *
<""* +
ProfileImageUseCase""+ >
>""> ?
(""? @
)""@ A
)""A B
;""B C
var## 
service## 
=## 
new## 
ProfileImageService## 1
(##1 2
useCase$$ 
,$$ 
accountAccessPolicy%% #
,%%# $
loggerFactory&& 
.&& 
CreateLogger&& *
<&&* +
ProfileImageService&&+ >
>&&> ?
(&&? @
)&&@ A
)&&A B
;&&B C
string'' 
endpointAddress'' "
=''# $ 
ConfigurationManager''% 9
.''9 :
AppSettings'': E
[''E F
$str''F c
]''c d
??''e g
$str(( >
;((> ?
var)) 
host)) 
=)) 
new)) 
ServiceHost)) &
())& '
service))' .
,)). /
new))0 3
Uri))4 7
())7 8
endpointAddress))8 G
)))G H
)))H I
;))I J
var** 
binding** 
=** 
new** 
NetTcpBinding** +
(**+ ,
SecurityMode**, 8
.**8 9
	Transport**9 B
)**B C
{++ "
MaxReceivedMessageSize,, &
=,,' (
ProfileImageLimits,,) ;
.,,; <(
MaximumTransportMessageBytes,,< X
,,,X Y
MaxBufferSize-- 
=-- 
ProfileImageLimits--  2
.--2 3(
MaximumTransportMessageBytes--3 O
,--O P
SendTimeout.. 
=.. 
TimeSpan.. &
...& '
FromSeconds..' 2
(..2 3
$num..3 4
)..4 5
,..5 6
ReceiveTimeout// 
=//  
TimeSpan//! )
.//) *
FromMinutes//* 5
(//5 6
$num//6 7
)//7 8
}00 
;00 
binding11 
.11 
ReaderQuotas11  
.11  !
MaxArrayLength11! /
=110 1
ProfileImageLimits112 D
.11D E
MaximumUploadBytes11E W
;11W X
binding22 
.22 
Security22 
.22 
	Transport22 &
.22& '
ProtectionLevel22' 6
=227 8
ProtectionLevel229 H
.22H I
EncryptAndSign22I W
;22W X
host33 
.33 
AddServiceEndpoint33 #
(33# $
typeof33$ *
(33* + 
IProfileImageService33+ ?
)33? @
,33@ A
binding33B I
,33I J
string33K Q
.33Q R
Empty33R W
)33W X
;33X Y
host44 
.44 
Description44 
.44 
	Behaviors44 &
.44& '
Add44' *
(44* +
new44+ .%
ServiceThrottlingBehavior44/ H
{55 
MaxConcurrentCalls66 "
=66# $
$num66% &
,66& '!
MaxConcurrentSessions77 %
=77& '
$num77( +
,77+ ,"
MaxConcurrentInstances88 &
=88' (
$num88) *
}99 
)99 
;99 
return:: 
host:: 
;:: 
};; 	
}<< 
}== ïÂ
FC:\Users\oscar\source\repos\TrickTakingMissions\Server\Host\Program.cs
	namespace 	
Host
 
{ 
internal 
static 
class 
Program !
{ 
private 
const 
int 
Port 
=  
$num! %
;% &
private 
const 
string 
LogsDirectoryName .
=/ 0
$str1 7
;7 8
private 
const 
string 
ServerLogFileName .
=/ 0
$str1 P
;P Q
private 
const 
string !
ServerStartedTemplate 2
=3 4
$str U
;U V
private   
const   
string   !
ServerStoppedTemplate   2
=  3 4
$str!! L
;!!L M
private"" 
const"" 
string""  
TimeoutFatalTemplate"" 1
=""2 3
$str## A
;##A B
private$$ 
const$$ 
string$$ &
CommunicationFatalTemplate$$ 7
=$$8 9
$str%% D
;%%D E
private&& 
const&& 
string&& )
InvalidOperationFatalTemplate&& :
=&&; <
$str'' X
;''X Y
private,, 
static,, 
void,, 
Main,,  
(,,  !
),,! "
{-- 	
CultureInfo.. 
serverCulture.. %
=..& '
CultureInfo..( 3
...3 4
GetCultureInfo..4 B
(..B C
$str..C J
)..J K
;..K L
CultureInfo// 
.// '
DefaultThreadCurrentCulture// 3
=//4 5
serverCulture//6 C
;//C D
CultureInfo00 
.00 )
DefaultThreadCurrentUICulture00 5
=006 7
serverCulture008 E
;00E F
ServiceHost22 
profileImageHost22 (
=22) *
null22+ /
;22/ 0
ServiceHost33 
	loginHost33 !
=33" #
null33$ (
;33( )
ServiceHost44 
	lobbyHost44 !
=44" #
null44$ (
;44( )
ServiceHost55 !
accountManagementHost55 -
=55. /
null550 4
;554 5
ServiceHost66 
friendshipHost66 &
=66' (
null66) -
;66- .
ServiceHost77 
friendsRequestHost77 *
=77+ ,
null77- 1
;771 2
string99 
logsDirectory99  
=99! "
Path99# '
.99' (
Combine99( /
(99/ 0
	AppDomain990 9
.999 :
CurrentDomain99: G
.99G H
BaseDirectory99H U
,99U V
LogsDirectoryName99W h
)99h i
;99i j
Log4NetConfigurator:: 
.::  
	Configure::  )
(::) *
logsDirectory::* 7
,::7 8
ServerLogFileName::9 J
)::J K
;::K L
ILoggerFactory;; 
loggerFactory;; (
=;;) *
new;;+ .
LoggerFactory;;/ <
(;;< =
);;= >
;;;> ?
ILoggerService<< 

hostLogger<< %
=<<& '
loggerFactory<<( 5
.<<5 6
CreateLogger<<6 B
(<<B C
typeof<<C I
(<<I J
Program<<J Q
)<<Q R
)<<R S
;<<S T
try>> 
{?? 
IUserRepository@@ 
userRepository@@  .
=@@/ 0
new@@1 4
UserRepository@@5 C
(@@C D
loggerFactory@@D Q
.@@Q R
CreateLogger@@R ^
<@@^ _
UserRepository@@_ m
>@@m n
(@@n o
)@@o p
)@@p q
;@@q r!
IFriendshipRepositoryAA % 
friendshipRepositoryAA& :
=AA; <
newAA= @ 
FriendshipRepositoryAAA U
(AAU V
loggerFactoryBB !
.BB! "
CreateLoggerBB" .
<BB. / 
FriendshipRepositoryBB/ C
>BBC D
(BBD E
)BBE F
)BBF G
;BBG H
IFriendshipUseCaseCC "
friendshipUseCaseCC# 4
=CC5 6
newCC7 :
FriendshipUseCaseCC; L
(CCL M 
friendshipRepositoryDD (
,DD( )
userRepositoryEE "
,EE" #
loggerFactoryFF !
.FF! "
CreateLoggerFF" .
<FF. /
FriendshipUseCaseFF/ @
>FF@ A
(FFA B
)FFB C
)FFC D
;FFD E
varHH $
chatInfractionRepositoryHH ,
=HH- .
newHH/ 2$
ChatInfractionRepositoryHH3 K
(HHK L
loggerFactoryII !
.II! "
CreateLoggerII" .
<II. /$
ChatInfractionRepositoryII/ G
>IIG H
(IIH I
)III J
)IIJ K
;IIK L
varJJ 
accountAccessPolicyJJ '
=JJ( )
newJJ* -
AccountAccessPolicyJJ. A
(JJA B
newKK /
#AuthenticatedAccountSessionRegistryKK ;
(KK; <
)KK< =
,KK= >$
chatInfractionRepositoryLL ,
,LL, -
loggerFactoryMM !
.MM! "
CreateLoggerMM" .
<MM. /
AccountAccessPolicyMM/ B
>MMB C
(MMC D
)MMD E
)MME F
;MMF G
varNN 
catalogBackupNN !
=NN" #
newNN$ ''
ChatModerationCatalogBackupNN( C
(NNC D
PathOO 
.OO 
CombineOO  
(OO  !
	AppDomainOO! *
.OO* +
CurrentDomainOO+ 8
.OO8 9
BaseDirectoryOO9 F
,OOF G
$strPP 2
,PP2 3
$strPP4 J
)PPJ K
)PPK L
;PPL M!
ChatModerationStartupQQ %
moderationStartupQQ& 7
=QQ8 9
newQQ: =!
ChatModerationStartupQQ> S
(QQS T
catalogBackupRR !
,RR! "
loggerFactorySS !
.SS! "
CreateLoggerSS" .
<SS. /!
ChatModerationStartupSS/ D
>SSD E
(SSE F
)SSF G
)SSG H
;SSH I%
ChatModerationPreparationTT )!
moderationPreparationTT* ?
=TT@ A
moderationStartupTTB S
.TTS T!
PrepareChatModerationTTT i
(TTi j
PathUU 
.UU 
CombineUU  
(UU  !
	AppDomainUU! *
.UU* +
CurrentDomainUU+ 8
.UU8 9
BaseDirectoryUU9 F
,UUF G
$strUUH \
)UU\ ]
)UU] ^
;UU^ _
varVV #
lobbyChatMessageUseCaseVV +
=VV, -
newVV. 1#
LobbyChatMessageUseCaseVV2 I
(VVI J!
moderationPreparationWW )
,WW) *$
chatInfractionRepositoryXX ,
,XX, -
loggerFactoryYY !
.YY! "
CreateLoggerYY" .
<YY. /#
LobbyChatMessageUseCaseYY/ F
>YYF G
(YYG H
)YYH I
)YYI J
;YYJ K
profileImageHostZZ  
=ZZ! "
ProfileImageHostingZZ# 6
.ZZ6 7
CreateZZ7 =
(ZZ= >
accountAccessPolicyZZ> Q
,ZZQ R
loggerFactoryZZS `
)ZZ` a
;ZZa b
	loginHost[[ 
=[[ &
CreateUserLoginServiceHost[[ 6
([[6 7
userRepository[[7 E
,[[E F
accountAccessPolicy[[G Z
,[[Z [
loggerFactory[[\ i
)[[i j
;[[j k
	lobbyHost\\ 
=\\ "
CreateLobbyServiceHost\\ 2
(\\2 3
new\\3 6
LobbyHostingContext\\7 J
{]] 
UserRepository^^ "
=^^# $
userRepository^^% 3
,^^3 4
ChatMessageUseCase__ &
=__' (#
lobbyChatMessageUseCase__) @
,__@ A
AccountAccessPolicy`` '
=``( )
accountAccessPolicy``* =
,``= >
LoggerFactoryaa !
=aa" #
loggerFactoryaa$ 1
}bb 
)bb 
;bb !
accountManagementHostcc %
=cc& '.
"CreateAccountManagementServiceHostcc( J
(ccJ K
userRepositoryccK Y
,ccY Z
loggerFactorycc[ h
)cch i
;cci j
friendshipHostdd 
=dd  '
CreateFriendshipServiceHostdd! <
(dd< =
friendshipUseCasedd= N
,ddN O
loggerFactoryddP ]
)dd] ^
;dd^ _
friendsRequestHostee "
=ee# $+
CreateFriendsRequestServiceHostee% D
(eeD E
friendshipUseCaseeeE V
,eeV W
loggerFactoryeeX e
)eee f
;eef g
profileImageHostgg  
.gg  !
Opengg! %
(gg% &
)gg& '
;gg' (
	loginHosthh 
.hh 
Openhh 
(hh 
)hh  
;hh  !
	lobbyHostii 
.ii 
Openii 
(ii 
)ii  
;ii  !!
accountManagementHostjj %
.jj% &
Openjj& *
(jj* +
)jj+ ,
;jj, -
friendshipHostkk 
.kk 
Openkk #
(kk# $
)kk$ %
;kk% &
friendsRequestHostll "
.ll" #
Openll# '
(ll' (
)ll( )
;ll) *

hostLoggernn 
.nn 
Informationnn &
(nn& '!
ServerStartedTemplatenn' <
,nn< =
Portnn> B
)nnB C
;nnC D
Consolepp 
.pp 
	WriteLinepp !
(pp! "
$strpp" J
)ppJ K
;ppK L
Consoleqq 
.qq 
	WriteLineqq !
(qq! "
$strqq" [
)qq[ \
;qq\ ]
Consolerr 
.rr 
	WriteLinerr !
(rr! "
$strrr" W
)rrW X
;rrX Y
Consoless 
.ss 
	WriteLiness !
(ss! "
$strss" c
)ssc d
;ssd e
Consolett 
.tt 
	WriteLinett !
(tt! "
$strtt" \
)tt\ ]
;tt] ^
Consoleuu 
.uu 
	WriteLineuu !
(uu! "
$struu" `
)uu` a
;uua b
Consolevv 
.vv 
	WriteLinevv !
(vv! "
$strvv" J
)vvJ K
;vvK L
Consoleww 
.ww 
ReadLineww  
(ww  !
)ww! "
;ww" #
profileImageHostyy  
.yy  !
Closeyy! &
(yy& '
)yy' (
;yy( )
friendsRequestHostzz "
.zz" #
Closezz# (
(zz( )
)zz) *
;zz* +
friendshipHost{{ 
.{{ 
Close{{ $
({{$ %
){{% &
;{{& '!
accountManagementHost|| %
.||% &
Close||& +
(||+ ,
)||, -
;||- .
	lobbyHost}} 
.}} 
Close}} 
(}}  
)}}  !
;}}! "
	loginHost~~ 
.~~ 
Close~~ 
(~~  
)~~  !
;~~! "

hostLogger
ÄÄ 
.
ÄÄ 
Information
ÄÄ &
(
ÄÄ& '#
ServerStoppedTemplate
ÄÄ' <
,
ÄÄ< =
Port
ÄÄ> B
)
ÄÄB C
;
ÄÄC D
}
ÅÅ 
catch
ÇÇ 
(
ÇÇ 
TimeoutException
ÇÇ #
ex
ÇÇ$ &
)
ÇÇ& '
{
ÉÉ 
profileImageHost
ÑÑ  
?
ÑÑ  !
.
ÑÑ! "
Abort
ÑÑ" '
(
ÑÑ' (
)
ÑÑ( )
;
ÑÑ) * 
friendsRequestHost
ÖÖ "
?
ÖÖ" #
.
ÖÖ# $
Abort
ÖÖ$ )
(
ÖÖ) *
)
ÖÖ* +
;
ÖÖ+ ,
friendshipHost
ÜÜ 
?
ÜÜ 
.
ÜÜ  
Abort
ÜÜ  %
(
ÜÜ% &
)
ÜÜ& '
;
ÜÜ' (#
accountManagementHost
áá %
?
áá% &
.
áá& '
Abort
áá' ,
(
áá, -
)
áá- .
;
áá. /
	lobbyHost
àà 
?
àà 
.
àà 
Abort
àà  
(
àà  !
)
àà! "
;
àà" #
	loginHost
ââ 
?
ââ 
.
ââ 
Abort
ââ  
(
ââ  !
)
ââ! "
;
ââ" #

hostLogger
ãã 
.
ãã 
Fatal
ãã  
(
ãã  !
ex
ãã! #
,
ãã# $"
TimeoutFatalTemplate
ãã% 9
,
ãã9 :
Port
ãã; ?
)
ãã? @
;
ãã@ A
}
åå 
catch
çç 
(
çç $
CommunicationException
çç )
ex
çç* ,
)
çç, -
{
éé 
profileImageHost
èè  
?
èè  !
.
èè! "
Abort
èè" '
(
èè' (
)
èè( )
;
èè) * 
friendsRequestHost
êê "
?
êê" #
.
êê# $
Abort
êê$ )
(
êê) *
)
êê* +
;
êê+ ,
friendshipHost
ëë 
?
ëë 
.
ëë  
Abort
ëë  %
(
ëë% &
)
ëë& '
;
ëë' (#
accountManagementHost
íí %
?
íí% &
.
íí& '
Abort
íí' ,
(
íí, -
)
íí- .
;
íí. /
	lobbyHost
ìì 
?
ìì 
.
ìì 
Abort
ìì  
(
ìì  !
)
ìì! "
;
ìì" #
	loginHost
îî 
?
îî 
.
îî 
Abort
îî  
(
îî  !
)
îî! "
;
îî" #

hostLogger
ññ 
.
ññ 
Fatal
ññ  
(
ññ  !
ex
ññ! #
,
ññ# $(
CommunicationFatalTemplate
ññ% ?
,
ññ? @
Port
ññA E
)
ññE F
;
ññF G
}
óó 
catch
òò 
(
òò '
InvalidOperationException
òò ,
ex
òò- /
)
òò/ 0
{
ôô 
profileImageHost
öö  
?
öö  !
.
öö! "
Abort
öö" '
(
öö' (
)
öö( )
;
öö) * 
friendsRequestHost
õõ "
?
õõ" #
.
õõ# $
Abort
õõ$ )
(
õõ) *
)
õõ* +
;
õõ+ ,
friendshipHost
úú 
?
úú 
.
úú  
Abort
úú  %
(
úú% &
)
úú& '
;
úú' (#
accountManagementHost
ùù %
?
ùù% &
.
ùù& '
Abort
ùù' ,
(
ùù, -
)
ùù- .
;
ùù. /
	lobbyHost
ûû 
?
ûû 
.
ûû 
Abort
ûû  
(
ûû  !
)
ûû! "
;
ûû" #
	loginHost
üü 
?
üü 
.
üü 
Abort
üü  
(
üü  !
)
üü! "
;
üü" #

hostLogger
°° 
.
°° 
Fatal
°°  
(
°°  !
ex
°°! #
,
°°# $+
InvalidOperationFatalTemplate
°°% B
,
°°B C
Port
°°D H
)
°°H I
;
°°I J
}
¢¢ 
}
££ 	
private
•• 
static
•• 
ServiceHost
•• "(
CreateUserLoginServiceHost
••# =
(
••= >
IUserRepository
••> M
userRepository
••N \
,
••\ ]"
IAccountAccessPolicy
¶¶  !
accountAccessPolicy
¶¶! 4
,
¶¶4 5
ILoggerFactory
¶¶6 D
loggerFactory
¶¶E R
)
¶¶R S
{
ßß 	
IUserLoginUseCase
®® 
userLoginUseCase
®® .
=
®®/ 0
new
®®1 4
UserLoginUseCase
®®5 E
(
®®E F
userRepository
©© 
,
©© 
loggerFactory
™™ 
.
™™ 
CreateLogger
™™ *
<
™™* +
UserLoginUseCase
™™+ ;
>
™™; <
(
™™< =
)
™™= >
)
™™> ?
;
™™? @
ILoggerService
´´ $
userLoginServiceLogger
´´ 1
=
´´2 3
loggerFactory
´´4 A
.
´´A B
CreateLogger
´´B N
<
´´N O
UserLoginService
´´O _
>
´´_ `
(
´´` a
)
´´a b
;
´´b c
var
¨¨ 
instanceProvider
¨¨  
=
¨¨! "
new
¨¨# &"
FuncInstanceProvider
¨¨' ;
<
¨¨; <
UserLoginService
¨¨< L
>
¨¨L M
(
¨¨M N
(
≠≠ 
)
≠≠ 
=>
≠≠ 
new
≠≠ 
UserLoginService
≠≠ *
(
≠≠* +
userLoginUseCase
≠≠+ ;
,
≠≠; <!
accountAccessPolicy
≠≠= P
,
≠≠P Q$
userLoginServiceLogger
≠≠R h
)
≠≠h i
)
≠≠i j
;
≠≠j k
IServiceBehavior
ÆÆ 
injectionBehavior
ÆÆ .
=
ÆÆ/ 0
new
ÆÆ1 40
"DependencyInjectionServiceBehavior
ÆÆ5 W
(
ÆÆW X
instanceProvider
ÆÆX h
)
ÆÆh i
;
ÆÆi j
ServiceHost
∞∞ 
serviceHost
∞∞ #
=
∞∞$ %
new
∞∞& )
ServiceHost
∞∞* 5
(
∞∞5 6
typeof
∞∞6 <
(
∞∞< =
UserLoginService
∞∞= M
)
∞∞M N
)
∞∞N O
;
∞∞O P
serviceHost
±± 
.
±± 
Description
±± #
.
±±# $
	Behaviors
±±$ -
.
±±- .
Add
±±. 1
(
±±1 2
injectionBehavior
±±2 C
)
±±C D
;
±±D E
return
≤≤ 
serviceHost
≤≤ 
;
≤≤ 
}
≥≥ 	
private
µµ 
static
µµ 
ServiceHost
µµ "$
CreateLobbyServiceHost
µµ# 9
(
µµ9 :!
LobbyHostingContext
µµ: M
context
µµN U
)
µµU V
{
∂∂ 	
IUserRepository
∑∑ 
userRepository
∑∑ *
=
∑∑+ ,
context
∑∑- 4
.
∑∑4 5
UserRepository
∑∑5 C
;
∑∑C D&
ILobbyChatMessageUseCase
∏∏ $%
lobbyChatMessageUseCase
∏∏% <
=
∏∏= >
context
∏∏? F
.
∏∏F G 
ChatMessageUseCase
∏∏G Y
;
∏∏Y Z"
IAccountAccessPolicy
ππ  !
accountAccessPolicy
ππ! 4
=
ππ5 6
context
ππ7 >
.
ππ> ?!
AccountAccessPolicy
ππ? R
;
ππR S
ILoggerFactory
∫∫ 
loggerFactory
∫∫ (
=
∫∫) *
context
∫∫+ 2
.
∫∫2 3
LoggerFactory
∫∫3 @
;
∫∫@ A
var
ªª 
matchUseCase
ªª 
=
ªª 
new
ªª "
MatchUseCase
ªª# /
(
ªª/ 0
new
ºº %
InMemoryMatchStateStore
ºº +
(
ºº+ ,
)
ºº, -
,
ºº- .
new
ΩΩ %
SecureMissionDeckDealer
ΩΩ +
(
ΩΩ+ ,
)
ΩΩ, -
,
ΩΩ- .
new
ææ (
MatchExecutionDependencies
ææ .
{
øø 
Logger
¿¿ 
=
¿¿ 
loggerFactory
¿¿ *
.
¿¿* +
CreateLogger
¿¿+ 7
<
¿¿7 8
MatchUseCase
¿¿8 D
>
¿¿D E
(
¿¿E F
)
¿¿F G
,
¿¿G H

MatchClock
¡¡ 
=
¡¡  
new
¡¡! $!
MonotonicMatchClock
¡¡% 8
(
¡¡8 9
)
¡¡9 :
,
¡¡: ;!
ParticipantPresence
¬¬ '
=
¬¬( )
new
¬¬* - 
LobbyMatchPresence
¬¬. @
(
¬¬@ A
loggerFactory
¬¬A N
.
¬¬N O
CreateLogger
¬¬O [
<
¬¬[ \ 
LobbyMatchPresence
¬¬\ n
>
¬¬n o
(
¬¬o p
)
¬¬p q
)
¬¬q r
}
√√ 
)
√√ 
;
√√ 
var
ƒƒ 
lobbyUseCase
ƒƒ 
=
ƒƒ 
new
ƒƒ "
LobbyUseCase
ƒƒ# /
(
ƒƒ/ 0
userRepository
≈≈ 
,
≈≈ 
new
∆∆  
LobbyHostSelection
∆∆ &
(
∆∆& '
)
∆∆' (
,
∆∆( )
matchUseCase
«« 
,
«« 
loggerFactory
»» 
.
»» 
CreateLogger
»» *
<
»»* +
LobbyUseCase
»»+ 7
>
»»7 8
(
»»8 9
)
»»9 :
)
»»: ;
;
»»; <
ILoggerService
……  
lobbyServiceLogger
…… -
=
……. /
loggerFactory
……0 =
.
……= >
CreateLogger
……> J
<
……J K
LobbyService
……K W
>
……W X
(
……X Y
)
……Y Z
;
……Z [
var
   
instanceProvider
    
=
  ! "
new
  # &"
FuncInstanceProvider
  ' ;
<
  ; <
LobbyService
  < H
>
  H I
(
  I J
(
ÀÀ 
)
ÀÀ 
=>
ÀÀ 
new
ÀÀ 
LobbyService
ÀÀ &
(
ÀÀ& '
lobbyUseCase
ÀÀ' 3
,
ÀÀ3 4%
lobbyChatMessageUseCase
ÀÀ5 L
,
ÀÀL M!
accountAccessPolicy
ÀÀN a
,
ÀÀa b 
lobbyServiceLogger
ÀÀc u
)
ÀÀu v
)
ÀÀv w
;
ÀÀw x
IServiceBehavior
ÃÃ 
injectionBehavior
ÃÃ .
=
ÃÃ/ 0
new
ÃÃ1 40
"DependencyInjectionServiceBehavior
ÃÃ5 W
(
ÃÃW X
instanceProvider
ÃÃX h
)
ÃÃh i
;
ÃÃi j
ServiceHost
ŒŒ 
serviceHost
ŒŒ #
=
ŒŒ$ %
new
ŒŒ& )
ServiceHost
ŒŒ* 5
(
ŒŒ5 6
typeof
ŒŒ6 <
(
ŒŒ< =
LobbyService
ŒŒ= I
)
ŒŒI J
)
ŒŒJ K
;
ŒŒK L
serviceHost
œœ 
.
œœ 
Description
œœ #
.
œœ# $
	Behaviors
œœ$ -
.
œœ- .
Add
œœ. 1
(
œœ1 2
injectionBehavior
œœ2 C
)
œœC D
;
œœD E
var
–– 
	scheduler
–– 
=
–– 
new
–– (
MissionTransitionScheduler
––  :
(
––: ;
matchUseCase
––; G
,
––G H
new
—— 
LobbyService
——  
(
——  !
lobbyUseCase
——! -
,
——- .%
lobbyChatMessageUseCase
——/ F
,
——F G!
accountAccessPolicy
——H [
,
——[ \ 
lobbyServiceLogger
——] o
)
——o p
,
——p q
loggerFactory
““ 
.
““ 
CreateLogger
““ *
<
““* +(
MissionTransitionScheduler
““+ E
>
““E F
(
““F G
)
““G H
)
““H I
;
““I J
serviceHost
”” 
.
”” 
Opened
”” 
+=
”” !
	scheduler
””" +
.
””+ ,
OnHostOpened
””, 8
;
””8 9
serviceHost
‘‘ 
.
‘‘ 
Closing
‘‘ 
+=
‘‘  "
	scheduler
‘‘# ,
.
‘‘, -
OnHostStopped
‘‘- :
;
‘‘: ;
serviceHost
’’ 
.
’’ 
Faulted
’’ 
+=
’’  "
	scheduler
’’# ,
.
’’, -
OnHostStopped
’’- :
;
’’: ;
return
÷÷ 
serviceHost
÷÷ 
;
÷÷ 
}
◊◊ 	
private
ŸŸ 
static
ŸŸ 
ServiceHost
ŸŸ "0
"CreateAccountManagementServiceHost
ŸŸ# E
(
ŸŸE F
IUserRepository
ŸŸF U
userRepository
ŸŸV d
,
ŸŸd e
ILoggerFactory
⁄⁄ 
loggerFactory
⁄⁄ (
)
⁄⁄( )
{
€€ 	
var
‹‹ +
blockedAccountEmailRepository
‹‹ -
=
‹‹. /
new
‹‹0 3+
BlockedAccountEmailRepository
‹‹4 Q
(
‹‹Q R
loggerFactory
›› 
.
›› 
CreateLogger
›› *
<
››* ++
BlockedAccountEmailRepository
››+ H
>
››H I
(
››I J
)
››J K
)
››K L
;
››L M
var
ﬁﬁ &
accountManagementUseCase
ﬁﬁ (
=
ﬁﬁ) *
new
ﬁﬁ+ .&
AccountManagementUseCase
ﬁﬁ/ G
(
ﬁﬁG H
userRepository
ﬂﬂ 
,
ﬂﬂ +
blockedAccountEmailRepository
‡‡ -
,
‡‡- .
loggerFactory
·· 
.
·· 
CreateLogger
·· *
<
··* +&
AccountManagementUseCase
··+ C
>
··C D
(
··D E
)
··E F
)
··F G
;
··G H
ILoggerService
‚‚ ,
accountManagementServiceLogger
‚‚ 9
=
‚‚: ;
loggerFactory
‚‚< I
.
‚‚I J
CreateLogger
‚‚J V
<
‚‚V W&
AccountManagementService
‚‚W o
>
‚‚o p
(
‚‚p q
)
‚‚q r
;
‚‚r s
var
„„ 
instanceProvider
„„  
=
„„! "
new
„„# &"
FuncInstanceProvider
„„' ;
<
„„; <&
AccountManagementService
„„< T
>
„„T U
(
„„U V
(
‰‰ 
)
‰‰ 
=>
‰‰ 
new
‰‰ &
AccountManagementService
‰‰ 2
(
‰‰2 3&
accountManagementUseCase
‰‰3 K
,
‰‰K L,
accountManagementServiceLogger
‰‰M k
)
‰‰k l
)
‰‰l m
;
‰‰m n
IServiceBehavior
ÂÂ 
injectionBehavior
ÂÂ .
=
ÂÂ/ 0
new
ÂÂ1 40
"DependencyInjectionServiceBehavior
ÂÂ5 W
(
ÂÂW X
instanceProvider
ÂÂX h
)
ÂÂh i
;
ÂÂi j
ServiceHost
ÁÁ 
serviceHost
ÁÁ #
=
ÁÁ$ %
new
ÁÁ& )
ServiceHost
ÁÁ* 5
(
ÁÁ5 6
typeof
ÁÁ6 <
(
ÁÁ< =&
AccountManagementService
ÁÁ= U
)
ÁÁU V
)
ÁÁV W
;
ÁÁW X
serviceHost
ËË 
.
ËË 
Description
ËË #
.
ËË# $
	Behaviors
ËË$ -
.
ËË- .
Add
ËË. 1
(
ËË1 2
injectionBehavior
ËË2 C
)
ËËC D
;
ËËD E
return
ÈÈ 
serviceHost
ÈÈ 
;
ÈÈ 
}
ÍÍ 	
private
ÏÏ 
static
ÏÏ 
ServiceHost
ÏÏ ")
CreateFriendshipServiceHost
ÏÏ# >
(
ÏÏ> ? 
IFriendshipUseCase
ÏÏ? Q
friendshipUseCase
ÏÏR c
,
ÏÏc d
ILoggerFactory
ÌÌ 
loggerFactory
ÌÌ (
)
ÌÌ( )
{
ÓÓ 	
ILoggerService
ÔÔ %
friendshipServiceLogger
ÔÔ 2
=
ÔÔ3 4
loggerFactory
ÔÔ5 B
.
ÔÔB C
CreateLogger
ÔÔC O
<
ÔÔO P
FriendshipService
ÔÔP a
>
ÔÔa b
(
ÔÔb c
)
ÔÔc d
;
ÔÔd e
var
 
instanceProvider
  
=
! "
new
# &"
FuncInstanceProvider
' ;
<
; <
FriendshipService
< M
>
M N
(
N O
(
ÒÒ 
)
ÒÒ 
=>
ÒÒ 
new
ÒÒ 
FriendshipService
ÒÒ +
(
ÒÒ+ ,
friendshipUseCase
ÒÒ, =
,
ÒÒ= >%
friendshipServiceLogger
ÒÒ? V
)
ÒÒV W
)
ÒÒW X
;
ÒÒX Y
IServiceBehavior
ÚÚ 
injectionBehavior
ÚÚ .
=
ÚÚ/ 0
new
ÚÚ1 40
"DependencyInjectionServiceBehavior
ÚÚ5 W
(
ÚÚW X
instanceProvider
ÚÚX h
)
ÚÚh i
;
ÚÚi j
ServiceHost
ÙÙ 
serviceHost
ÙÙ #
=
ÙÙ$ %
new
ÙÙ& )
ServiceHost
ÙÙ* 5
(
ÙÙ5 6
typeof
ÙÙ6 <
(
ÙÙ< =
FriendshipService
ÙÙ= N
)
ÙÙN O
)
ÙÙO P
;
ÙÙP Q
serviceHost
ıı 
.
ıı 
Description
ıı #
.
ıı# $
	Behaviors
ıı$ -
.
ıı- .
Add
ıı. 1
(
ıı1 2
injectionBehavior
ıı2 C
)
ııC D
;
ııD E
return
ˆˆ 
serviceHost
ˆˆ 
;
ˆˆ 
}
˜˜ 	
private
˘˘ 
static
˘˘ 
ServiceHost
˘˘ "-
CreateFriendsRequestServiceHost
˘˘# B
(
˘˘B C 
IFriendshipUseCase
˘˘C U
friendshipUseCase
˘˘V g
,
˘˘g h
ILoggerFactory
˙˙ 
loggerFactory
˙˙ (
)
˙˙( )
{
˚˚ 	
ILoggerService
¸¸ )
friendsRequestServiceLogger
¸¸ 6
=
¸¸7 8
loggerFactory
¸¸9 F
.
¸¸F G
CreateLogger
¸¸G S
<
¸¸S T#
FriendsRequestService
¸¸T i
>
¸¸i j
(
¸¸j k
)
¸¸k l
;
¸¸l m
var
˝˝ 
instanceProvider
˝˝  
=
˝˝! "
new
˝˝# &"
FuncInstanceProvider
˝˝' ;
<
˝˝; <#
FriendsRequestService
˝˝< Q
>
˝˝Q R
(
˝˝R S
(
˛˛ 
)
˛˛ 
=>
˛˛ 
new
˛˛ #
FriendsRequestService
˛˛ /
(
˛˛/ 0
friendshipUseCase
˛˛0 A
,
˛˛A B)
friendsRequestServiceLogger
˛˛C ^
)
˛˛^ _
)
˛˛_ `
;
˛˛` a
IServiceBehavior
ˇˇ 
injectionBehavior
ˇˇ .
=
ˇˇ/ 0
new
ˇˇ1 40
"DependencyInjectionServiceBehavior
ˇˇ5 W
(
ˇˇW X
instanceProvider
ˇˇX h
)
ˇˇh i
;
ˇˇi j
ServiceHost
ÅÅ 
serviceHost
ÅÅ #
=
ÅÅ$ %
new
ÅÅ& )
ServiceHost
ÅÅ* 5
(
ÅÅ5 6
typeof
ÅÅ6 <
(
ÅÅ< =#
FriendsRequestService
ÅÅ= R
)
ÅÅR S
)
ÅÅS T
;
ÅÅT U
serviceHost
ÇÇ 
.
ÇÇ 
Description
ÇÇ #
.
ÇÇ# $
	Behaviors
ÇÇ$ -
.
ÇÇ- .
Add
ÇÇ. 1
(
ÇÇ1 2
injectionBehavior
ÇÇ2 C
)
ÇÇC D
;
ÇÇD E
return
ÉÉ 
serviceHost
ÉÉ 
;
ÉÉ 
}
ÑÑ 	
}
ÖÖ 
}ÜÜ 
gC:\Users\oscar\source\repos\TrickTakingMissions\Server\Host\DependencyInjection\FuncInstanceProvider.cs
	namespace 	
Host
 
. 
DependencyInjection "
{ 
public 

sealed 
class  
FuncInstanceProvider ,
<, -
TService- 5
>5 6
:7 8
IInstanceProvider9 J
where 
TService 
: 
class 
{ 
private 
readonly 
Func 
< 
TService &
>& '
_instanceFactory( 8
;8 9
public  
FuncInstanceProvider #
(# $
Func$ (
<( )
TService) 1
>1 2
instanceFactory3 B
)B C
{ 	
if 
( 
instanceFactory 
==  "
null# '
)' (
{ 
throw 
new !
ArgumentNullException /
(/ 0
nameof0 6
(6 7
instanceFactory7 F
)F G
)G H
;H I
} 
_instanceFactory 
= 
instanceFactory .
;. /
} 	
public 
object 
GetInstance !
(! "
InstanceContext" 1
instanceContext2 A
)A B
{ 	
return 
_instanceFactory #
(# $
)$ %
;% &
} 	
public   
object   
GetInstance   !
(  ! "
InstanceContext  " 1
instanceContext  2 A
,  A B
Message  C J
message  K R
)  R S
{!! 	
return"" 
_instanceFactory"" #
(""# $
)""$ %
;""% &
}## 	
public%% 
void%% 
ReleaseInstance%% #
(%%# $
InstanceContext%%$ 3
instanceContext%%4 C
,%%C D
object%%E K
instance%%L T
)%%T U
{&& 	
IDisposable'' 

disposable'' "
=''# $
instance''% -
as''. 0
IDisposable''1 <
;''< =
if(( 
((( 

disposable(( 
!=(( 
null(( "
)((" #
{)) 

disposable** 
.** 
Dispose** "
(**" #
)**# $
;**$ %
}++ 
},, 	
}-- 
}.. ©
uC:\Users\oscar\source\repos\TrickTakingMissions\Server\Host\DependencyInjection\DependencyInjectionServiceBehavior.cs
	namespace 	
Host
 
. 
DependencyInjection "
{		 
public 

sealed 
class .
"DependencyInjectionServiceBehavior :
:; <
IServiceBehavior= M
{ 
private 
readonly 
IInstanceProvider *
_instanceProvider+ <
;< =
public .
"DependencyInjectionServiceBehavior 1
(1 2
IInstanceProvider2 C
instanceProviderD T
)T U
{ 	
if 
( 
instanceProvider  
==! #
null$ (
)( )
{ 
throw 
new !
ArgumentNullException /
(/ 0
nameof0 6
(6 7
instanceProvider7 G
)G H
)H I
;I J
} 
_instanceProvider 
= 
instanceProvider  0
;0 1
} 	
public 
void  
AddBindingParameters (
(( )
ServiceDescription) ;
serviceDescription< N
,N O
ServiceHostBaseP _
serviceHostBase` o
,o p

Collection 
< 
ServiceEndpoint &
>& '
	endpoints( 1
,1 2&
BindingParameterCollection3 M
bindingParametersN _
)_ `
{ 	
} 	
public   
void   !
ApplyDispatchBehavior   )
(  ) *
ServiceDescription  * <
serviceDescription  = O
,  O P
ServiceHostBase  Q `
serviceHostBase  a p
)  p q
{!! 	
if"" 
("" 
serviceHostBase"" 
==""  "
null""# '
)""' (
{## 
throw$$ 
new$$ !
ArgumentNullException$$ /
($$/ 0
nameof$$0 6
($$6 7
serviceHostBase$$7 F
)$$F G
)$$G H
;$$H I
}%% 
foreach'' 
('' !
ChannelDispatcherBase'' *!
channelDispatcherBase''+ @
in''A C
serviceHostBase''D S
.''S T
ChannelDispatchers''T f
)''f g
{(( 
ChannelDispatcher)) !
channelDispatcher))" 3
=))4 5!
channelDispatcherBase))6 K
as))L N
ChannelDispatcher))O `
;))` a
if** 
(** 
channelDispatcher** %
!=**& (
null**) -
)**- .
{++ 
foreach,, 
(,, 
EndpointDispatcher,, /
endpointDispatcher,,0 B
in,,C E
channelDispatcher,,F W
.,,W X
	Endpoints,,X a
),,a b
{-- 
if.. 
(.. 
!.. 
endpointDispatcher.. /
.../ 0
IsSystemEndpoint..0 @
)..@ A
{// 
endpointDispatcher00 .
.00. /
DispatchRuntime00/ >
.00> ?
InstanceProvider00? O
=00P Q
_instanceProvider00R c
;00c d
}11 
}22 
}33 
}44 
}55 	
public77 
void77 
Validate77 
(77 
ServiceDescription77 /
serviceDescription770 B
,77B C
ServiceHostBase77D S
serviceHostBase77T c
)77c d
{88 	
}99 	
}:: 
};; ®
QC:\Users\oscar\source\repos\TrickTakingMissions\Server\Host\LobbyHostSelection.cs
	namespace 	
Host
 
{ 
public		 

sealed		 
class		 
LobbyHostSelection		 *
:		+ ,
ILobbyHostSelection		- @
{

 
private 
readonly 
Random  
_hostSelectionRandom  4
=5 6
new7 :
Random; A
(A B
)B C
;C D
private 
readonly 
object 
_hostSelectionLock  2
=3 4
new5 8
object9 ?
(? @
)@ A
;A B
public 
int 
SelectHostUserId #
(# $
IReadOnlyList$ 1
<1 2
int2 5
>5 6&
eligibleParticipantUserIds7 Q
)Q R
{ 	
int 
selectedHostUserId "
=# $
$num% &
;& '
lock 
( 
_hostSelectionLock $
)$ %
{ 
if 
( &
eligibleParticipantUserIds .
.. /
Count/ 4
>5 6
$num7 8
)8 9
{ 
selectedHostUserId &
=' (&
eligibleParticipantUserIds) C
[C D 
_hostSelectionRandom ,
., -
Next- 1
(1 2&
eligibleParticipantUserIds2 L
.L M
CountM R
)R S
]S T
;T U
} 
} 
return 
selectedHostUserId %
;% &
} 	
} 
} 