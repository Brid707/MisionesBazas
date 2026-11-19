ØS
nC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Rules\TrickFollowSuitRules.cs
	namespace

 	
TrickTakingMissions


 
.

 
Rules

 #
.

# $
Rules

$ )
{ 
public 

static 
class  
TrickFollowSuitRules ,
{ 
private 
const 
int 
MinimumPlayerCount ,
=- .
$num/ 0
;0 1
private 
const 
int 
MaximumPlayerCount ,
=- .
$num/ 0
;0 1
public 
static %
TrickPlayValidationResult /
ValidatePlay0 <
(< =
TrickPlayContext= M
trickPlayContextN ^
)^ _
{ 	$
TrickPlayRejectionReason $
rejectionReason% 4
=5 6
GetRejectionReason7 I
(I J
trickPlayContextJ Z
)Z [
;[ \%
TrickPlayValidationResult %
validationResult& 6
=7 8
rejectionReason9 H
==I K$
TrickPlayRejectionReasonL d
.d e
Nonee i
? %
TrickPlayValidationResult +
.+ ,
Legal, 1
(1 2
)2 3
: %
TrickPlayValidationResult +
.+ ,
Illegal, 3
(3 4
rejectionReason4 C
)C D
;D E
return 
validationResult #
;# $
} 	
public 
static 
IReadOnlyList #
<# $
int$ '
>' (
GetPlayableCards) 9
(9 :
IReadOnlyList: G
<G H
CardH L
>L M

playerHandN X
,X Y
IReadOnlyList 
< 
TrickCardPlay '
>' (#
currentTrickPlayedCards) @
)@ A
{ 	
List 
< 
int 
> 
playableCardIds %
=& '
new( +
List, 0
<0 1
int1 4
>4 5
(5 6
)6 7
;7 8
if   
(   

playerHand   
!=   
null   "
)  " #
{!! 
TrickCardPlay"" 
leadPlay"" &
=""' (
LeadCardResolver"") 9
.""9 :
GetLeadPlay"": E
(""E F#
currentTrickPlayedCards""F ]
)""] ^
;""^ _
bool##  
shouldFollowLeadSuit## )
=##* +
leadPlay##, 4
!=##5 7
null##8 <
&&##= ?
HasCardOfSuit##@ M
(##M N

playerHand##N X
,##X Y
leadPlay##Z b
.##b c
Card##c g
.##g h
Suit##h l
)##l m
;##m n
foreach%% 
(%% 
Card%% 
card%% "
in%%# %

playerHand%%& 0
)%%0 1
{&& 
if'' 
('' 
!''  
shouldFollowLeadSuit'' -
||''. 0
card''1 5
.''5 6
Suit''6 :
==''; =
leadPlay''> F
.''F G
Card''G K
.''K L
Suit''L P
||''Q S
card''T X
.''X Y
Suit''Y ]
==''^ `
CardSuit''a i
.''i j
Special''j q
)''q r
{(( 
playableCardIds)) '
.))' (
Add))( +
())+ ,
card)), 0
.))0 1
IdCard))1 7
)))7 8
;))8 9
}** 
}++ 
},, 
return.. 
playableCardIds.. "
..." #

AsReadOnly..# -
(..- .
)... /
;../ 0
}// 	
private11 
static11 $
TrickPlayRejectionReason11 /
GetRejectionReason110 B
(11B C
TrickPlayContext11C S
context11T [
)11[ \
{22 	$
TrickPlayRejectionReason33 $
rejectionReason33% 4
=335 6$
TrickPlayRejectionReason337 O
.33O P
None33P T
;33T U
if44 
(44 
!44 
IsContextValid44 
(44  
context44  '
)44' (
)44( )
{55 
rejectionReason66 
=66  !$
TrickPlayRejectionReason66" :
.66: ;
InvalidPlayContext66; M
;66M N
}77 
else88 
if88 
(88 
context88 
.88 #
CurrentTrickPlayedCards88 4
.884 5
Count885 :
>=88; =
context88> E
.88E F
PlayerCount88F Q
)88Q R
{99 
rejectionReason:: 
=::  !$
TrickPlayRejectionReason::" :
.::: ;!
TrickAlreadyCompleted::; P
;::P Q
};; 
else<< 
if<< 
(<< 
context<< 
.<< 

PlayerSeat<< '
!=<<( *
context<<+ 2
.<<2 3
CurrentTurnSeat<<3 B
)<<B C
{== 
rejectionReason>> 
=>>  !$
TrickPlayRejectionReason>>" :
.>>: ;
NotPlayerTurn>>; H
;>>H I
}?? 
else@@ 
if@@ 
(@@ 
!@@ 
IsCardInHand@@ "
(@@" #
context@@# *
.@@* +

PlayerHand@@+ 5
,@@5 6
context@@7 >
.@@> ?
CandidateCard@@? L
)@@L M
)@@M N
{AA 
rejectionReasonBB 
=BB  !$
TrickPlayRejectionReasonBB" :
.BB: ;
CardNotInHandBB; H
;BBH I
}CC 
elseDD 
ifDD 
(DD  
IsFollowSuitViolatedDD )
(DD) *
contextDD* 1
)DD1 2
)DD2 3
{EE 
rejectionReasonFF 
=FF  !$
TrickPlayRejectionReasonFF" :
.FF: ;
MustFollowLeadSuitFF; M
;FFM N
}GG 
returnHH 
rejectionReasonHH "
;HH" #
}II 	
privateKK 
staticKK 
boolKK 
IsContextValidKK *
(KK* +
TrickPlayContextKK+ ;
contextKK< C
)KKC D
{LL 	
returnMM 
contextMM 
!=MM 
nullMM "
&&NN 
contextNN 
.NN 

PlayerHandNN %
!=NN& (
nullNN) -
&&OO 
contextOO 
.OO #
CurrentTrickPlayedCardsOO 2
!=OO3 5
nullOO6 :
&&PP 
contextPP 
.PP 
CandidateCardPP (
!=PP) +
nullPP, 0
&&QQ 
contextQQ 
.QQ 
PlayerCountQQ &
>=QQ' )
MinimumPlayerCountQQ* <
&&RR 
contextRR 
.RR 
PlayerCountRR &
<=RR' )
MaximumPlayerCountRR* <
;RR< =
}SS 	
privateUU 
staticUU 
boolUU 
IsCardInHandUU (
(UU( )
IReadOnlyListUU) 6
<UU6 7
CardUU7 ;
>UU; <

playerHandUU= G
,UUG H
CardUUI M
candidateCardUUN [
)UU[ \
{VV 	
boolWW 
isCardInHandWW 
=WW 
falseWW  %
;WW% &
intXX 
	cardIndexXX 
=XX 
$numXX 
;XX 
whileZZ 
(ZZ 
!ZZ 
isCardInHandZZ  
&&ZZ! #
	cardIndexZZ$ -
<ZZ. /

playerHandZZ0 :
.ZZ: ;
CountZZ; @
)ZZ@ A
{[[ 
isCardInHand\\ 
=\\ 

playerHand\\ )
[\\) *
	cardIndex\\* 3
]\\3 4
.\\4 5
IdCard\\5 ;
==\\< >
candidateCard\\? L
.\\L M
IdCard\\M S
;\\S T
	cardIndex]] 
++]] 
;]] 
}^^ 
return`` 
isCardInHand`` 
;``  
}aa 	
privatecc 
staticcc 
boolcc  
IsFollowSuitViolatedcc 0
(cc0 1
TrickPlayContextcc1 A
contextccB I
)ccI J
{dd 	
boolee  
isFollowSuitViolatedee %
=ee& '
falseee( -
;ee- .
TrickCardPlayff 
leadPlayff "
=ff# $
LeadCardResolverff% 5
.ff5 6
GetLeadPlayff6 A
(ffA B
contextffB I
.ffI J#
CurrentTrickPlayedCardsffJ a
)ffa b
;ffb c
ifhh 
(hh 
leadPlayhh 
!=hh 
nullhh  
)hh  !
{ii 
CardSuitjj 
leadSuitjj !
=jj" #
leadPlayjj$ ,
.jj, -
Cardjj- 1
.jj1 2
Suitjj2 6
;jj6 7 
isFollowSuitViolatedkk $
=kk% &
contextkk' .
.kk. /
CandidateCardkk/ <
.kk< =
Suitkk= A
!=kkB D
leadSuitkkE M
&&ll 
contextll 
.ll 
CandidateCardll ,
.ll, -
Suitll- 1
!=ll2 4
CardSuitll5 =
.ll= >
Specialll> E
&&mm 
HasCardOfSuitmm $
(mm$ %
contextmm% ,
.mm, -

PlayerHandmm- 7
,mm7 8
leadSuitmm9 A
)mmA B
;mmB C
}nn 
returnpp  
isFollowSuitViolatedpp '
;pp' (
}qq 	
privatess 
staticss 
boolss 
HasCardOfSuitss )
(ss) *
IReadOnlyListss* 7
<ss7 8
Cardss8 <
>ss< =

playerHandss> H
,ssH I
CardSuitssJ R
suitssS W
)ssW X
{tt 	
booluu 
hasCardOfSuituu 
=uu  
falseuu! &
;uu& '
intvv 
	cardIndexvv 
=vv 
$numvv 
;vv 
whilexx 
(xx 
!xx 
hasCardOfSuitxx !
&&xx" $
	cardIndexxx% .
<xx/ 0

playerHandxx1 ;
.xx; <
Countxx< A
)xxA B
{yy 
hasCardOfSuitzz 
=zz 

playerHandzz  *
[zz* +
	cardIndexzz+ 4
]zz4 5
.zz5 6
Suitzz6 :
==zz; =
suitzz> B
;zzB C
	cardIndex{{ 
++{{ 
;{{ 
}|| 
return~~ 
hasCardOfSuit~~  
;~~  !
} 	
}
ÄÄ 
}ÅÅ Ô!
jC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Rules\TrickWinnerRules.cs
	namespace		 	
TrickTakingMissions		
 
.		 
Rules		 #
.		# $
Rules		$ )
{

 
public 

static 
class 
TrickWinnerRules (
{ 
public 
static 
TrickCardPlay # 
DetermineTrickWinner$ 8
(8 9
IReadOnlyList9 F
<F G
TrickCardPlayG T
>T U

trickPlaysV `
)` a
{ 	
if 
( 

trickPlays 
is 
null "
)" #
{ 
throw 
new !
ArgumentNullException /
(/ 0
nameof0 6
(6 7

trickPlays7 A
)A B
)B C
;C D
} 
if 
( 

trickPlays 
. 
Count  
==! #
$num$ %
)% &
{ 
throw 
new '
ArgumentOutOfRangeException 5
(5 6
nameof6 <
(< =

trickPlays= G
)G H
)H I
;I J
} 
TrickCardPlay 
leadPlay "
=# $
LeadCardResolver% 5
.5 6
GetLeadPlay6 A
(A B

trickPlaysB L
)L M
;M N
CardSuit 
leadSuit 
= 
leadPlay  (
.( )
Card) -
.- .
Suit. 2
;2 3
TrickCardPlay 
winningPlay %
=& '
leadPlay( 0
;0 1
foreach 
( 
TrickCardPlay "
	trickPlay# ,
in- /

trickPlays0 :
): ;
{ 
if 
( 
IsChallengerWinning '
(' (
	trickPlay( 1
.1 2
Card2 6
,6 7
winningPlay8 C
.C D
CardD H
,H I
leadSuitJ R
)R S
)S T
{ 
winningPlay   
=    !
	trickPlay  " +
;  + ,
}!! 
}"" 
return$$ 
winningPlay$$ 
;$$ 
}%% 	
private'' 
static'' 
bool'' 
IsChallengerWinning'' /
(''/ 0
Card''0 4
challengerCard''5 C
,''C D
Card''E I
currentWinnerCard''J [
,''[ \
CardSuit''] e
leadSuit''f n
)''n o
{(( 	
bool)) 
isChallengerSpecial)) $
=))% &
challengerCard))' 5
.))5 6
Suit))6 :
==)); =
CardSuit))> F
.))F G
Special))G N
;))N O
bool** "
isCurrentWinnerSpecial** '
=**( )
currentWinnerCard*** ;
.**; <
Suit**< @
==**A C
CardSuit**D L
.**L M
Special**M T
;**T U
bool++ 
isChallengerWinning++ $
;++$ %
if-- 
(-- 
isChallengerSpecial-- #
&&--$ &"
isCurrentWinnerSpecial--' =
)--= >
{.. 
isChallengerWinning// #
=//$ %
challengerCard//& 4
.//4 5
SpecialSymbol//5 B
>//C D
currentWinnerCard//E V
.//V W
SpecialSymbol//W d
;//d e
}00 
else11 
if11 
(11 
isChallengerSpecial11 (
||11) +"
isCurrentWinnerSpecial11, B
)11B C
{22 
isChallengerWinning33 #
=33$ %
isChallengerSpecial33& 9
;339 :
}44 
else55 
{66 
isChallengerWinning77 #
=77$ %
challengerCard77& 4
.774 5
Suit775 9
==77: <
leadSuit77= E
&&88 
challengerCard88 %
.88% &
Number88& ,
>88- .
currentWinnerCard88/ @
.88@ A
Number88A G
;88G H
}99 
return;; 
isChallengerWinning;; &
;;;& '
}<< 	
}== 
}>> ‚ë
qC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Rules\RadioCommunicationRules.cs
	namespace 	
TrickTakingMissions
 
. 
Rules #
.# $
Rules$ )
{ 
public 

static 
class #
RadioCommunicationRules /
{ 
private 
const 
int '
DisruptionTrickTwoThreshold 5
=6 7
$num8 9
;9 :
private 
const 
int )
DisruptionTrickThreeThreshold 7
=8 9
$num: ;
;; <
public 
static .
"RadioCommunicationValidationResult 8!
ValidateCommunication9 N
(N O%
RadioCommunicationContextO h
contexti p
)p q
{ 	
if 
( 
context 
is 
null 
)  
{ 
throw 
new !
ArgumentNullException /
(/ 0
nameof0 6
(6 7
context7 >
)> ?
)? @
;@ A
} -
!RadioCommunicationRejectionReason   -
prerequisiteFailure  . A
=  B C!
EvaluatePrerequisites  D Y
(  Y Z
context  Z a
)  a b
;  b c.
"RadioCommunicationValidationResult!! .
result!!/ 5
=!!6 7.
"RadioCommunicationValidationResult!!8 Z
.!!Z [
Reject!![ a
(!!a b
prerequisiteFailure!!b u
)!!u v
;!!v w
if"" 
("" 
prerequisiteFailure"" #
==""$ &-
!RadioCommunicationRejectionReason""' H
.""H I
None""I M
)""M N
{## 
result$$ 
=$$ 
context$$  
.$$  !
CommunicationRule$$! 2
==$$3 5!
CommunicationRuleType$$6 K
.$$K L
Interference$$L X
?%%  
EvaluateInterference%% *
(%%* +
context%%+ 2
)%%2 3
:%%4 5!
EvaluateTokenPosition%%6 K
(%%K L
context%%L S
)%%S T
;%%T U
}&& 
return'' 
result'' 
;'' 
}(( 	
private** 
static** .
"RadioCommunicationValidationResult** 9 
EvaluateInterference**: N
(**N O%
RadioCommunicationContext**O h
context**i p
)**p q
{++ 	
bool,, 
isEligibleCard,, 
=,,  !+
ResolveNonInterferencePositions-- /
(--/ 0
context--0 7
.--7 8
	HandCards--8 A
,--A B
context--C J
.--J K
CardToCommunicate--K \
)--\ ]
.--] ^
Count--^ c
>--d e
$num--f g
;--g h
return.. 
isEligibleCard.. !
&&.." $
context..% ,
..., -
SelectedPosition..- =
==..> @
RadioTokenPosition..A S
...S T
Interference..T `
?// .
"RadioCommunicationValidationResult// 4
.//4 5
Success//5 <
(//< =
RadioTokenPosition//= O
.//O P
Interference//P \
)//\ ]
:00 .
"RadioCommunicationValidationResult00 4
.004 5
Reject005 ;
(00; <-
!RadioCommunicationRejectionReason11 5
.115 6'
InvalidTokenPositionForCard116 Q
)11Q R
;11R S
}22 	
public;; 
static;; 
IReadOnlyList;; #
<;;# $
RadioTokenPosition;;$ 6
>;;6 7$
GetValidPositionsForCard;;8 P
(;;P Q
IReadOnlyList<< 
<<< 
Card<< 
><< 
	handCards<<  )
,<<) *
Card== 
candidateCard== 
,== !
CommunicationRuleType>> !
communicationRule>>" 3
)>>3 4
{?? 	
IReadOnlyList@@ 
<@@ 
RadioTokenPosition@@ ,
>@@, -
	positions@@. 7
=@@8 9
Array@@: ?
.@@? @
Empty@@@ E
<@@E F
RadioTokenPosition@@F X
>@@X Y
(@@Y Z
)@@Z [
;@@[ \
ifAA 
(AA 
	handCardsAA 
!=AA 
nullAA !
&&AA" $
candidateCardAA% 2
!=AA3 5
nullAA6 :
&&AA; =
candidateCardAA> K
.AAK L
SuitAAL P
!=AAQ S
CardSuitAAT \
.AA\ ]
SpecialAA] d
&&AAe g
	handCardsBB 
.BB 
AnyBB 
(BB 
cardBB "
=>BB# %
cardBB& *
.BB* +
IdCardBB+ 1
==BB2 4
candidateCardBB5 B
.BBB C
IdCardBBC I
)BBI J
)BBJ K
{CC 
	positionsDD 
=DD +
ResolveNonInterferencePositionsDD ;
(DD; <
	handCardsDD< E
,DDE F
candidateCardDDG T
)DDT U
;DDU V
ifEE 
(EE 
communicationRuleEE %
==EE& (!
CommunicationRuleTypeEE) >
.EE> ?
InterferenceEE? K
&&EEL N
	positionsEEO X
.EEX Y
CountEEY ^
>EE_ `
$numEEa b
)EEb c
{FF 
	positionsGG 
=GG 
newGG  #
[GG# $
]GG$ %
{GG& '
RadioTokenPositionGG( :
.GG: ;
InterferenceGG; G
}GGH I
;GGI J
}HH 
}II 
returnJJ 
	positionsJJ 
;JJ 
}KK 	
privateMM 
staticMM -
!RadioCommunicationRejectionReasonMM 8!
EvaluatePrerequisitesMM9 N
(MMN O%
RadioCommunicationContextMMO h
contextMMi p
)MMp q
{NN 	-
!RadioCommunicationRejectionReasonOO -
	rejectionOO. 7
=OO8 9$
GetAvailabilityRejectionOO: R
(OOR S
contextOOS Z
)OOZ [
;OO[ \
ifPP 
(PP 
	rejectionPP 
==PP -
!RadioCommunicationRejectionReasonPP >
.PP> ?
NonePP? C
)PPC D
{QQ 
	rejectionRR 
=RR *
EvaluateCandidatePrerequisitesRR :
(RR: ;
contextRR; B
)RRB C
;RRC D
}SS 
returnTT 
	rejectionTT 
;TT 
}UU 	
privateWW 
staticWW -
!RadioCommunicationRejectionReasonWW 8*
EvaluateCandidatePrerequisitesWW9 W
(WWW X%
RadioCommunicationContextWWX q
contextXX 
)XX 
{YY 	-
!RadioCommunicationRejectionReasonZZ -
	rejectionZZ. 7
=ZZ8 9-
!RadioCommunicationRejectionReasonZZ: [
.ZZ[ \
NoneZZ\ `
;ZZ` a
if[[ 
([[ 
context[[ 
.[[ 
CardToCommunicate[[ )
==[[* ,
null[[- 1
||[[2 4
context[[5 <
.[[< =
	HandCards[[= F
==[[G I
null[[J N
||[[O Q
!\\ 
context\\ 
.\\ 
	HandCards\\ "
.\\" #
Any\\# &
(\\& '
card\\' +
=>\\, .
card\\/ 3
.\\3 4
IdCard\\4 :
==\\; =
context\\> E
.\\E F
CardToCommunicate\\F W
.\\W X
IdCard\\X ^
)\\^ _
)\\_ `
{]] 
	rejection^^ 
=^^ -
!RadioCommunicationRejectionReason^^ =
.^^= >
CardNotInHand^^> K
;^^K L
}__ 
else`` 
if`` 
(`` 
context`` 
.`` 
CardToCommunicate`` .
.``. /
Suit``/ 3
==``4 6
CardSuit``7 ?
.``? @
Special``@ G
)``G H
{aa 
	rejectionbb 
=bb -
!RadioCommunicationRejectionReasonbb =
.bb= >!
SpecialCardNotAllowedbb> S
;bbS T
}cc 
returndd 
	rejectiondd 
;dd 
}ee 	
publichh 
statichh -
!RadioCommunicationRejectionReasonhh 7$
GetAvailabilityRejectionhh8 P
(hhP Q%
RadioCommunicationContexthhQ j
contexthhk r
)hhr s
{ii 	
ifjj 
(jj 
contextjj 
==jj 
nulljj 
)jj  
{kk 
throwll 
newll !
ArgumentNullExceptionll /
(ll/ 0
nameofll0 6
(ll6 7
contextll7 >
)ll> ?
)ll? @
;ll@ A
}mm -
!RadioCommunicationRejectionReasonnn -
	rejectionnn. 7
=nn8 9-
!RadioCommunicationRejectionReasonnn: [
.nn[ \
Nonenn\ `
;nn` a
ifoo 
(oo 
IsDisruptedoo 
(oo 
contextoo #
.oo# $
CommunicationRuleoo$ 5
,oo5 6
contextoo7 >
.oo> ?
CurrentTrickNumberoo? Q
)ooQ R
)ooR S
{pp 
	rejectionqq 
=qq -
!RadioCommunicationRejectionReasonqq =
.qq= >
DisruptedUntilTrickqq> Q
;qqQ R
}rr 
ifss 
(ss 
contextss 
.ss 
IsTrickInProgressss )
)ss) *
{tt 
	rejectionuu 
=uu -
!RadioCommunicationRejectionReasonuu =
.uu= >.
"CannotCommunicateDuringActiveTrickuu> `
;uu` a
}vv 
ifww 
(ww 
contextww 
.ww 
IsSilencedByCaptainww +
)ww+ ,
{xx 
	rejectionyy 
=yy -
!RadioCommunicationRejectionReasonyy =
.yy= >
SilencedByCaptainyy> O
;yyO P
}zz 
if{{ 
({{ 
context{{ 
.{{ &
HasCommunicatedThisAttempt{{ 2
){{2 3
{|| 
	rejection}} 
=}} -
!RadioCommunicationRejectionReason}} =
.}}= >*
AlreadyCommunicatedThisAttempt}}> \
;}}\ ]
}~~ 
return 
	rejection 
; 
}
ÄÄ 	
private
ÇÇ 
static
ÇÇ 
bool
ÇÇ 
IsDisrupted
ÇÇ '
(
ÇÇ' (#
CommunicationRuleType
ÇÇ( =
rule
ÇÇ> B
,
ÇÇB C
int
ÇÇD G 
currentTrickNumber
ÇÇH Z
)
ÇÇZ [
{
ÉÉ 	
bool
ÑÑ #
isDisruptedAtTrickTwo
ÑÑ &
=
ÑÑ' (
rule
ÑÑ) -
==
ÑÑ. 0#
CommunicationRuleType
ÑÑ1 F
.
ÑÑF G#
DisruptionUntilTrick2
ÑÑG \
&&
ÑÑ] _ 
currentTrickNumber
ÖÖ) ;
<
ÖÖ< =)
DisruptionTrickTwoThreshold
ÖÖ> Y
;
ÖÖY Z
bool
ÜÜ %
isDisruptedAtTrickThree
ÜÜ (
=
ÜÜ) *
rule
ÜÜ+ /
==
ÜÜ0 2#
CommunicationRuleType
ÜÜ3 H
.
ÜÜH I#
DisruptionUntilTrick3
ÜÜI ^
&&
ÜÜ_ a 
currentTrickNumber
áá+ =
<
áá> ?+
DisruptionTrickThreeThreshold
áá@ ]
;
áá] ^
return
ââ #
isDisruptedAtTrickTwo
ââ (
||
ââ) +%
isDisruptedAtTrickThree
ââ, C
;
ââC D
}
ää 	
private
åå 
static
åå 0
"RadioCommunicationValidationResult
åå 9#
EvaluateTokenPosition
åå: O
(
ååO P'
RadioCommunicationContext
ååP i
context
ååj q
)
ååq r
{
çç 	
List
éé 
<
éé 
Card
éé 
>
éé 
cardsOfSameSuit
éé &
=
éé' (
context
éé) 0
.
éé0 1
	HandCards
éé1 :
.
èè 
Where
èè 
(
èè 
card
èè 
=>
èè 
card
èè #
.
èè# $
Suit
èè$ (
==
èè) +
context
èè, 3
.
èè3 4
CardToCommunicate
èè4 E
.
èèE F
Suit
èèF J
)
èèJ K
.
êê 
ToList
êê 
(
êê 
)
êê 
;
êê 
if
íí 
(
íí 
cardsOfSameSuit
íí 
.
íí  
Count
íí  %
==
íí& (
$num
íí) *
)
íí* +
{
ìì 
return
îî 
context
îî 
.
îî 
SelectedPosition
îî /
==
îî0 2 
RadioTokenPosition
îî3 E
.
îîE F
Only
îîF J
?
ïï 0
"RadioCommunicationValidationResult
ïï 8
.
ïï8 9
Success
ïï9 @
(
ïï@ A 
RadioTokenPosition
ïïA S
.
ïïS T
Only
ïïT X
)
ïïX Y
:
ññ 0
"RadioCommunicationValidationResult
ññ 8
.
ññ8 9
Reject
ññ9 ?
(
ññ? @/
!RadioCommunicationRejectionReason
ññ@ a
.
ñña b)
InvalidTokenPositionForCard
ññb }
)
ññ} ~
;
ññ~ 
}
óó 
int
ôô !
highestNumberInSuit
ôô #
=
ôô$ %
cardsOfSameSuit
ôô& 5
.
ôô5 6
Max
ôô6 9
(
ôô9 :
card
ôô: >
=>
ôô? A
card
ôôB F
.
ôôF G
Number
ôôG M
)
ôôM N
;
ôôN O
int
öö  
lowestNumberInSuit
öö "
=
öö# $
cardsOfSameSuit
öö% 4
.
öö4 5
Min
öö5 8
(
öö8 9
card
öö9 =
=>
öö> @
card
ööA E
.
ööE F
Number
ööF L
)
ööL M
;
ööM N
bool
úú 
	isHighest
úú 
=
úú 
context
úú $
.
úú$ %
CardToCommunicate
úú% 6
.
úú6 7
Number
úú7 =
==
úú> @!
highestNumberInSuit
úúA T
&&
úúU W
context
ùù $
.
ùù$ %
SelectedPosition
ùù% 5
==
ùù6 8 
RadioTokenPosition
ùù9 K
.
ùùK L
Highest
ùùL S
;
ùùS T
bool
ûû 
isLowest
ûû 
=
ûû 
context
ûû #
.
ûû# $
CardToCommunicate
ûû$ 5
.
ûû5 6
Number
ûû6 <
==
ûû= ? 
lowestNumberInSuit
ûû@ R
&&
ûûS U
context
üü #
.
üü# $
SelectedPosition
üü$ 4
==
üü5 7 
RadioTokenPosition
üü8 J
.
üüJ K
Lowest
üüK Q
;
üüQ R
if
°° 
(
°° 
	isHighest
°° 
)
°° 
{
¢¢ 
return
££ 0
"RadioCommunicationValidationResult
££ 9
.
££9 :
Success
££: A
(
££A B 
RadioTokenPosition
££B T
.
££T U
Highest
££U \
)
££\ ]
;
££] ^
}
§§ 
if
¶¶ 
(
¶¶ 
isLowest
¶¶ 
)
¶¶ 
{
ßß 
return
®® 0
"RadioCommunicationValidationResult
®® 9
.
®®9 :
Success
®®: A
(
®®A B 
RadioTokenPosition
®®B T
.
®®T U
Lowest
®®U [
)
®®[ \
;
®®\ ]
}
©© 
return
´´ 0
"RadioCommunicationValidationResult
´´ 5
.
´´5 6
Reject
´´6 <
(
´´< =/
!RadioCommunicationRejectionReason
´´= ^
.
´´^ _)
InvalidTokenPositionForCard
´´_ z
)
´´z {
;
´´{ |
}
¨¨ 	
private
ÆÆ 
static
ÆÆ 
IReadOnlyList
ÆÆ $
<
ÆÆ$ % 
RadioTokenPosition
ÆÆ% 7
>
ÆÆ7 8-
ResolveNonInterferencePositions
ÆÆ9 X
(
ÆÆX Y
IReadOnlyList
ØØ 
<
ØØ 
Card
ØØ 
>
ØØ 
	handCards
ØØ  )
,
ØØ) *
Card
∞∞ 
candidateCard
∞∞ 
)
∞∞ 
{
±± 	
List
≤≤ 
<
≤≤ 
Card
≤≤ 
>
≤≤ 
cardsOfSameSuit
≤≤ &
=
≤≤' (
	handCards
≤≤) 2
.
≥≥ 
Where
≥≥ 
(
≥≥ 
card
≥≥ 
=>
≥≥ 
card
≥≥ #
.
≥≥# $
Suit
≥≥$ (
==
≥≥) +
candidateCard
≥≥, 9
.
≥≥9 :
Suit
≥≥: >
)
≥≥> ?
.
¥¥ 
ToList
¥¥ 
(
¥¥ 
)
¥¥ 
;
¥¥ 
if
∂∂ 
(
∂∂ 
cardsOfSameSuit
∂∂ 
.
∂∂  
Count
∂∂  %
==
∂∂& (
$num
∂∂) *
)
∂∂* +
{
∑∑ 
return
∏∏ 
new
∏∏ 
[
∏∏ 
]
∏∏ 
{
∏∏  
RadioTokenPosition
∏∏ 1
.
∏∏1 2
Only
∏∏2 6
}
∏∏7 8
;
∏∏8 9
}
ππ 
var
ªª 
validPositions
ªª 
=
ªª  
new
ªª! $
List
ªª% )
<
ªª) * 
RadioTokenPosition
ªª* <
>
ªª< =
(
ªª= >
$num
ªª> ?
)
ªª? @
;
ªª@ A
int
ºº !
highestNumberInSuit
ºº #
=
ºº$ %
cardsOfSameSuit
ºº& 5
.
ºº5 6
Max
ºº6 9
(
ºº9 :
card
ºº: >
=>
ºº? A
card
ººB F
.
ººF G
Number
ººG M
)
ººM N
;
ººN O
int
ΩΩ  
lowestNumberInSuit
ΩΩ "
=
ΩΩ# $
cardsOfSameSuit
ΩΩ% 4
.
ΩΩ4 5
Min
ΩΩ5 8
(
ΩΩ8 9
card
ΩΩ9 =
=>
ΩΩ> @
card
ΩΩA E
.
ΩΩE F
Number
ΩΩF L
)
ΩΩL M
;
ΩΩM N
if
øø 
(
øø 
candidateCard
øø 
.
øø 
Number
øø $
==
øø% '!
highestNumberInSuit
øø( ;
)
øø; <
{
¿¿ 
validPositions
¡¡ 
.
¡¡ 
Add
¡¡ "
(
¡¡" # 
RadioTokenPosition
¡¡# 5
.
¡¡5 6
Highest
¡¡6 =
)
¡¡= >
;
¡¡> ?
}
¬¬ 
if
ƒƒ 
(
ƒƒ 
candidateCard
ƒƒ 
.
ƒƒ 
Number
ƒƒ $
==
ƒƒ% ' 
lowestNumberInSuit
ƒƒ( :
)
ƒƒ: ;
{
≈≈ 
validPositions
∆∆ 
.
∆∆ 
Add
∆∆ "
(
∆∆" # 
RadioTokenPosition
∆∆# 5
.
∆∆5 6
Lowest
∆∆6 <
)
∆∆< =
;
∆∆= >
}
«« 
return
…… 
validPositions
…… !
.
……! "

AsReadOnly
……" ,
(
……, -
)
……- .
;
……. /
}
   	
}
ÀÀ 
}ÃÃ ±
jC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Rules\LeadCardResolver.cs
	namespace 	
TrickTakingMissions
 
. 
Rules #
.# $
Rules$ )
{ 
internal 
static 
class 
LeadCardResolver *
{ 
internal		 
static		 
TrickCardPlay		 %
GetLeadPlay		& 1
(		1 2
IReadOnlyList		2 ?
<		? @
TrickCardPlay		@ M
>		M N

trickPlays		O Y
)		Y Z
{

 	
TrickCardPlay 
leadPlay "
=# $
null% )
;) *
if 
( 

trickPlays 
!= 
null "
)" #
{ 
foreach 
( 
TrickCardPlay &
	trickPlay' 0
in1 3

trickPlays4 >
)> ?
{ 
if 
( 
leadPlay  
is! #
null$ (
||) +
	trickPlay, 5
.5 6
	PlayOrder6 ?
<@ A
leadPlayB J
.J K
	PlayOrderK T
)T U
{ 
leadPlay  
=! "
	trickPlay# ,
;, -
} 
} 
} 
return 
leadPlay 
; 
} 	
} 
} Äò
hC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Rules\MissionCatalog.cs
	namespace 	
TrickTakingMissions
 
. 
Rules #
.# $
Rules$ )
{ 
public 

static 
class 
MissionCatalog &
{ 
public 
const 
int  
MinimumMissionNumber -
=. /
$num0 1
;1 2
public 
const 
int  
MaximumMissionNumber -
=. /
$num0 2
;2 3
private 
const 
int 
ZeroObjectivesCount -
=. /
$num0 1
;1 2
private 
const 
int 
OneObjectiveCount +
=, -
$num. /
;/ 0
private 
const 
int 
TwoObjectivesCount ,
=- .
$num/ 0
;0 1
private 
const 
int  
ThreeObjectivesCount .
=/ 0
$num1 2
;2 3
private 
const 
int 
FourObjectivesCount -
=. /
$num0 1
;1 2
private 
const 
int 
FiveObjectivesCount -
=. /
$num0 1
;1 2
private 
const 
int 
SixObjectivesCount ,
=- .
$num/ 0
;0 1
private 
const 
int  
SevenObjectivesCount .
=/ 0
$num1 2
;2 3
private 
const 
int  
EightObjectivesCount .
=/ 0
$num1 2
;2 3
private 
const 
int 
NineObjectivesCount -
=. /
$num0 1
;1 2
private 
const 
int 
TenObjectivesCount ,
=- .
$num/ 1
;1 2
private 
const 
string  
Mission01Description 1
=2 3
$str4 K
;K L
private 
const 
string  
Mission02Description 1
=2 3
$str4 L
;L M
private 
const 
string  
Mission03Description 1
=2 3
$str4 c
;c d
private 
const 
string  
Mission04Description 1
=2 3
$str4 L
;L M
private   
const   
string    
Mission05Description   1
=  2 3
$str  4 Y
;  Y Z
private!! 
const!! 
string!!  
Mission06Description!! 1
=!!2 3
$str!!4 o
;!!o p
private"" 
const"" 
string""  
Mission07Description"" 1
=""2 3
$str""4 i
;""i j
private## 
const## 
string##  
Mission08Description## 1
=##2 3
$str##4 f
;##f g
private$$ 
const$$ 
string$$  
Mission09Description$$ 1
=$$2 3
$str$$4 g
;$$g h
private%% 
const%% 
string%%  
Mission10Description%% 1
=%%2 3
$str%%4 L
;%%L M
private&& 
const&& 
string&&  
Mission11Description&& 1
=&&2 3
$str&&4 q
+&&r s
$str'' ,
;'', -
private(( 
const(( 
string((  
Mission12Description(( 1
=((2 3
$str((4 i
;((i j
private)) 
const)) 
string))  
Mission13Description)) 1
=))2 3
$str))4 i
;))i j
private** 
const** 
string**  
Mission14Description** 1
=**2 3
$str**4 q
+**r s
$str++ "
;++" #
private,, 
const,, 
string,,  
Mission15Description,, 1
=,,2 3
$str,,4 i
;,,i j
private-- 
const-- 
string--  
Mission16Description-- 1
=--2 3
$str--4 b
;--b c
private.. 
const.. 
string..  
Mission17Description.. 1
=..2 3
$str..4 q
+..r s
$str// 
;// 
private00 
const00 
string00  
Mission18Description00 1
=002 3
$str004 s
;00s t
private11 
const11 
string11  
Mission19Description11 1
=112 3
$str114 u
+11v w
$str22 
;22 
private33 
const33 
string33  
Mission20Description33 1
=332 3
$str334 s
+33t u
$str44 
;44 
private55 
const55 
string55  
Mission21Description55 1
=552 3
$str554 e
;55e f
private66 
const66 
string66  
Mission22Description66 1
=662 3
$str664 v
;66v w
private77 
const77 
string77  
Mission23Description77 1
=772 3
$str774 l
;77l m
private88 
const88 
string88  
Mission24Description88 1
=882 3
$str884 L
;88L M
private99 
const99 
string99  
Mission25Description99 1
=992 3
$str994 o
;99o p
private:: 
const:: 
string::  
Mission26Description:: 1
=::2 3
$str::4 j
;::j k
private;; 
const;; 
string;;  
Mission27Description;; 1
=;;2 3
$str;;4 s
+;;t u
$str<< 
;<< 
private== 
const== 
string==  
Mission28Description== 1
===2 3
$str==4 i
+==j k
$str>> 4
;>>4 5
private?? 
const?? 
string??  
Mission29Description?? 1
=??2 3
$str??4 t
+??u v
$str@@ 9
;@@9 :
privateAA 
constAA 
stringAA  
Mission30DescriptionAA 1
=AA2 3
$strAA4 p
;AAp q
privateBB 
constBB 
stringBB  
Mission31DescriptionBB 1
=BB2 3
$strBB4 f
;BBf g
privateCC 
constCC 
stringCC  
Mission32DescriptionCC 1
=CC2 3
$strCC4 L
;CCL M
privateDD 
constDD 
stringDD  
Mission33DescriptionDD 1
=DD2 3
$strDD4 r
+DDs t
$strEE #
;EE# $
privateFF 
constFF 
stringFF  
Mission34DescriptionFF 1
=FF2 3
$strFF4 m
+FFn o
$strGG G
;GGG H
privateHH 
constHH 
stringHH  
Mission35DescriptionHH 1
=HH2 3
$strHH4 p
;HHp q
privateII 
constII 
stringII  
Mission36DescriptionII 1
=II2 3
$strII4 c
;IIc d
privateJJ 
constJJ 
stringJJ  
Mission37DescriptionJJ 1
=JJ2 3
$strJJ4 L
;JJL M
privateKK 
constKK 
stringKK  
Mission38DescriptionKK 1
=KK2 3
$strKK4 L
;KKL M
privateLL 
constLL 
stringLL  
Mission39DescriptionLL 1
=LL2 3
$strLL4 p
;LLp q
privateMM 
constMM 
stringMM  
Mission40DescriptionMM 1
=MM2 3
$strMM4 f
;MMf g
privateNN 
constNN 
stringNN  
Mission41DescriptionNN 1
=NN2 3
$strNN4 p
+NNq r
$strOO 1
;OO1 2
privatePP 
constPP 
stringPP  
Mission42DescriptionPP 1
=PP2 3
$strPP4 L
;PPL M
privateQQ 
constQQ 
stringQQ  
Mission43DescriptionQQ 1
=QQ2 3
$strQQ4 L
;QQL M
privateRR 
constRR 
stringRR  
Mission44DescriptionRR 1
=RR2 3
$strRR4 l
+RRm n
$strSS ,
;SS, -
privateTT 
constTT 
stringTT  
Mission45DescriptionTT 1
=TT2 3
$strTT4 p
;TTp q
privateUU 
constUU 
stringUU  
Mission46DescriptionUU 1
=UU2 3
$strUU4 t
+UUu v
$strVV ,
;VV, -
privateWW 
constWW 
stringWW  
Mission47DescriptionWW 1
=WW2 3
$strWW4 M
;WWM N
privateXX 
constXX 
stringXX  
Mission48DescriptionXX 1
=XX2 3
$strXX4 s
+XXt u
$strYY !
;YY! "
privateZZ 
constZZ 
stringZZ  
Mission49DescriptionZZ 1
=ZZ2 3
$strZZ4 q
;ZZq r
private[[ 
const[[ 
string[[  
Mission50Description[[ 1
=[[2 3
$str[[4 r
+[[s t
$str\\ V
;\\V W
private^^ 
static^^ 
readonly^^ 
IReadOnlyDictionary^^  3
<^^3 4
int^^4 7
,^^7 8
MissionDefinition^^9 J
>^^J K
	_missions^^L U
=^^V W
BuildCatalog^^X d
(^^d e
)^^e f
;^^f g
private__ 
static__ 
readonly__ 
IReadOnlyList__  -
<__- .
MissionDefinition__. ?
>__? @
_allMissions__A M
=__N O 
BuildAllMissionsList__P d
(__d e
	_missions__e n
)__n o
;__o p
publicgg 
staticgg 
MissionDefinitiongg '

GetMissiongg( 2
(gg2 3
intgg3 6
missionNumbergg7 D
)ggD E
{hh 	
ifii 
(ii 
missionNumberii 
<ii  
MinimumMissionNumberii  4
||ii5 7
missionNumberii8 E
>iiF G 
MaximumMissionNumberiiH \
)ii\ ]
{jj 
throwkk 
newkk '
ArgumentOutOfRangeExceptionkk 5
(kk5 6
nameofkk6 <
(kk< =
missionNumberkk= J
)kkJ K
)kkK L
;kkL M
}ll 
returnnn 
	_missionsnn 
[nn 
missionNumbernn *
]nn* +
;nn+ ,
}oo 	
publicuu 
staticuu 
IReadOnlyListuu #
<uu# $
MissionDefinitionuu$ 5
>uu5 6
GetAllMissionsuu7 E
(uuE F
)uuF G
{vv 	
returnww 
_allMissionsww 
;ww  
}xx 	
privatezz 
staticzz 
IReadOnlyListzz $
<zz$ %
MissionDefinitionzz% 6
>zz6 7 
BuildAllMissionsListzz8 L
(zzL M
IReadOnlyDictionaryzzM `
<zz` a
intzza d
,zzd e
MissionDefinition{{ 
>{{ 
missions{{ '
){{' (
{|| 	
var}} 
orderedList}} 
=}} 
new}} !
List}}" &
<}}& '
MissionDefinition}}' 8
>}}8 9
(}}9 :
missions}}: B
.}}B C
Count}}C H
)}}H I
;}}I J
for 
( 
int 
missionIndex !
=" # 
MinimumMissionNumber$ 8
;8 9
missionIndex: F
<=G I 
MaximumMissionNumberJ ^
;^ _
missionIndex` l
++l n
)n o
{
ÄÄ 
orderedList
ÅÅ 
.
ÅÅ 
Add
ÅÅ 
(
ÅÅ  
missions
ÅÅ  (
[
ÅÅ( )
missionIndex
ÅÅ) 5
]
ÅÅ5 6
)
ÅÅ6 7
;
ÅÅ7 8
}
ÇÇ 
return
ÑÑ 
orderedList
ÑÑ 
.
ÑÑ 

AsReadOnly
ÑÑ )
(
ÑÑ) *
)
ÑÑ* +
;
ÑÑ+ ,
}
ÖÖ 	
private
áá 
static
áá !
IReadOnlyDictionary
áá *
<
áá* +
int
áá+ .
,
áá. /
MissionDefinition
áá0 A
>
ááA B
BuildCatalog
ááC O
(
ááO P
)
ááP Q
{
àà 	
var
ââ 
missions
ââ 
=
ââ 
new
ââ 

Dictionary
ââ )
<
ââ) *
int
ââ* -
,
ââ- .
MissionDefinition
ââ/ @
>
ââ@ A
(
ââA B"
MaximumMissionNumber
ââB V
)
ââV W
;
ââW X
RegisterMission
ãã 
(
ãã 
missions
ãã $
,
ãã$ %
new
ãã& )
MissionDefinition
ãã* ;
{
ãã< =
MissionNumber
ãã> K
=
ããL M
$num
ããN O
,
ããO P 
ObjectiveCardCount
ããQ c
=
ããd e
OneObjectiveCount
ããf w
,
ããw x
Tokens
åå 
=
åå 
Array
åå 
.
åå 
Empty
åå $
<
åå$ % 
ObjectiveTokenType
åå% 7
>
åå7 8
(
åå8 9
)
åå9 :
,
åå: ;
CommunicationRule
åå< M
=
ååN O#
CommunicationRuleType
ååP e
.
ååe f
Standard
ååf n
,
åån o
SpecialRule
çç 
=
çç $
SpecialMissionRuleType
çç 4
.
çç4 5
None
çç5 9
,
çç9 :
Description
çç; F
=
ççG H"
Mission01Description
ççI ]
}
çç^ _
)
çç_ `
;
çç` a
RegisterMission
éé 
(
éé 
missions
éé $
,
éé$ %
new
éé& )
MissionDefinition
éé* ;
{
éé< =
MissionNumber
éé> K
=
ééL M
$num
ééN O
,
ééO P 
ObjectiveCardCount
ééQ c
=
ééd e 
TwoObjectivesCount
ééf x
,
ééx y
Tokens
èè 
=
èè 
Array
èè 
.
èè 
Empty
èè $
<
èè$ % 
ObjectiveTokenType
èè% 7
>
èè7 8
(
èè8 9
)
èè9 :
,
èè: ;
CommunicationRule
èè< M
=
èèN O#
CommunicationRuleType
èèP e
.
èèe f
Standard
èèf n
,
èèn o
SpecialRule
êê 
=
êê $
SpecialMissionRuleType
êê 4
.
êê4 5
None
êê5 9
,
êê9 :
Description
êê; F
=
êêG H"
Mission02Description
êêI ]
}
êê^ _
)
êê_ `
;
êê` a
RegisterMission
ëë 
(
ëë 
missions
ëë $
,
ëë$ %
new
ëë& )
MissionDefinition
ëë* ;
{
ëë< =
MissionNumber
ëë> K
=
ëëL M
$num
ëëN O
,
ëëO P 
ObjectiveCardCount
ëëQ c
=
ëëd e 
TwoObjectivesCount
ëëf x
,
ëëx y
Tokens
íí 
=
íí 
Array
íí 
.
íí 

AsReadOnly
íí )
(
íí) *
new
íí* -
[
íí- .
]
íí. /
{
íí0 1 
ObjectiveTokenType
íí2 D
.
ííD E
OrderOne
ííE M
,
ííM N 
ObjectiveTokenType
ííO a
.
íía b
OrderTwo
ííb j
}
íík l
)
ííl m
,
íím n
CommunicationRule
ìì !
=
ìì" ##
CommunicationRuleType
ìì$ 9
.
ìì9 :
Standard
ìì: B
,
ììB C
SpecialRule
ììD O
=
ììP Q$
SpecialMissionRuleType
ììR h
.
ììh i
None
ììi m
,
ììm n
Description
îî 
=
îî "
Mission03Description
îî 2
}
îî3 4
)
îî4 5
;
îî5 6
RegisterMission
ïï 
(
ïï 
missions
ïï $
,
ïï$ %
new
ïï& )
MissionDefinition
ïï* ;
{
ïï< =
MissionNumber
ïï> K
=
ïïL M
$num
ïïN O
,
ïïO P 
ObjectiveCardCount
ïïQ c
=
ïïd e"
ThreeObjectivesCount
ïïf z
,
ïïz {
Tokens
ññ 
=
ññ 
Array
ññ 
.
ññ 
Empty
ññ $
<
ññ$ % 
ObjectiveTokenType
ññ% 7
>
ññ7 8
(
ññ8 9
)
ññ9 :
,
ññ: ;
CommunicationRule
ññ< M
=
ññN O#
CommunicationRuleType
ññP e
.
ññe f
Standard
ññf n
,
ññn o
SpecialRule
óó 
=
óó $
SpecialMissionRuleType
óó 4
.
óó4 5
None
óó5 9
,
óó9 :
Description
óó; F
=
óóG H"
Mission04Description
óóI ]
}
óó^ _
)
óó_ `
;
óó` a
RegisterMission
òò 
(
òò 
missions
òò $
,
òò$ %
new
òò& )
MissionDefinition
òò* ;
{
òò< =
MissionNumber
òò> K
=
òòL M
$num
òòN O
,
òòO P 
ObjectiveCardCount
òòQ c
=
òòd e!
ZeroObjectivesCount
òòf y
,
òòy z
Tokens
ôô 
=
ôô 
Array
ôô 
.
ôô 
Empty
ôô $
<
ôô$ % 
ObjectiveTokenType
ôô% 7
>
ôô7 8
(
ôô8 9
)
ôô9 :
,
ôô: ;
CommunicationRule
ôô< M
=
ôôN O#
CommunicationRuleType
ôôP e
.
ôôe f
Standard
ôôf n
,
ôôn o
SpecialRule
öö 
=
öö $
SpecialMissionRuleType
öö 4
.
öö4 5'
M05_OnePlayerWinsNoTricks
öö5 N
,
ööN O
Description
õõ 
=
õõ "
Mission05Description
õõ 2
}
õõ3 4
)
õõ4 5
;
õõ5 6
RegisterMission
úú 
(
úú 
missions
úú $
,
úú$ %
new
úú& )
MissionDefinition
úú* ;
{
úú< =
MissionNumber
úú> K
=
úúL M
$num
úúN O
,
úúO P 
ObjectiveCardCount
ùù "
=
ùù# $"
ThreeObjectivesCount
ùù% 9
,
ùù9 :
Tokens
ùù; A
=
ùùB C
Array
ùùD I
.
ùùI J

AsReadOnly
ùùJ T
(
ùùT U
new
ùùU X
[
ùùX Y
]
ùùY Z
{
ûû  
ObjectiveTokenType
ûû $
.
ûû$ %
ArrowOne
ûû% -
,
ûû- . 
ObjectiveTokenType
ûû/ A
.
ûûA B
ArrowTwo
ûûB J
}
ûûK L
)
ûûL M
,
ûûM N
CommunicationRule
üü !
=
üü" ##
CommunicationRuleType
üü$ 9
.
üü9 :
Interference
üü: F
,
üüF G
SpecialRule
üüH S
=
üüT U$
SpecialMissionRuleType
üüV l
.
üül m
None
üüm q
,
üüq r
Description
†† 
=
†† "
Mission06Description
†† 2
}
††3 4
)
††4 5
;
††5 6
RegisterMission
°° 
(
°° 
missions
°° $
,
°°$ %
new
°°& )
MissionDefinition
°°* ;
{
°°< =
MissionNumber
°°> K
=
°°L M
$num
°°N O
,
°°O P 
ObjectiveCardCount
°°Q c
=
°°d e"
ThreeObjectivesCount
°°f z
,
°°z {
Tokens
¢¢ 
=
¢¢ 
Array
¢¢ 
.
¢¢ 

AsReadOnly
¢¢ )
(
¢¢) *
new
¢¢* -
[
¢¢- .
]
¢¢. /
{
¢¢0 1 
ObjectiveTokenType
¢¢2 D
.
¢¢D E
Omega
¢¢E J
}
¢¢K L
)
¢¢L M
,
¢¢M N
CommunicationRule
££ !
=
££" ##
CommunicationRuleType
££$ 9
.
££9 :
Standard
££: B
,
££B C
SpecialRule
££D O
=
££P Q$
SpecialMissionRuleType
££R h
.
££h i
None
££i m
,
££m n
Description
§§ 
=
§§ "
Mission07Description
§§ 2
}
§§3 4
)
§§4 5
;
§§5 6
RegisterMission
•• 
(
•• 
missions
•• $
,
••$ %
new
••& )
MissionDefinition
••* ;
{
••< =
MissionNumber
••> K
=
••L M
$num
••N O
,
••O P 
ObjectiveCardCount
••Q c
=
••d e"
ThreeObjectivesCount
••f z
,
••z {
Tokens
¶¶ 
=
¶¶ 
Array
¶¶ 
.
¶¶ 

AsReadOnly
¶¶ )
(
¶¶) *
new
¶¶* -
[
¶¶- .
]
¶¶. /
{
¶¶0 1 
ObjectiveTokenType
¶¶2 D
.
¶¶D E
OrderOne
¶¶E M
,
¶¶M N 
ObjectiveTokenType
¶¶O a
.
¶¶a b
OrderTwo
¶¶b j
,
¶¶j k 
ObjectiveTokenType
ßß &
.
ßß& '

OrderThree
ßß' 1
}
ßß2 3
)
ßß3 4
,
ßß4 5
CommunicationRule
ßß6 G
=
ßßH I#
CommunicationRuleType
ßßJ _
.
ßß_ `
Standard
ßß` h
,
ßßh i
SpecialRule
®® 
=
®® $
SpecialMissionRuleType
®® 4
.
®®4 5
None
®®5 9
,
®®9 :
Description
©© 
=
©© "
Mission08Description
©© 2
}
©©3 4
)
©©4 5
;
©©5 6
RegisterMission
™™ 
(
™™ 
missions
™™ $
,
™™$ %
new
™™& )
MissionDefinition
™™* ;
{
™™< =
MissionNumber
™™> K
=
™™L M
$num
™™N O
,
™™O P 
ObjectiveCardCount
™™Q c
=
™™d e!
ZeroObjectivesCount
™™f y
,
™™y z
Tokens
´´ 
=
´´ 
Array
´´ 
.
´´ 
Empty
´´ $
<
´´$ % 
ObjectiveTokenType
´´% 7
>
´´7 8
(
´´8 9
)
´´9 :
,
´´: ;
CommunicationRule
´´< M
=
´´N O#
CommunicationRuleType
´´P e
.
´´e f
Standard
´´f n
,
´´n o
SpecialRule
¨¨ 
=
¨¨ $
SpecialMissionRuleType
¨¨ 4
.
¨¨4 5'
M09_WinTrickWithNumberOne
¨¨5 N
,
¨¨N O
Description
≠≠ 
=
≠≠ "
Mission09Description
≠≠ 2
}
≠≠3 4
)
≠≠4 5
;
≠≠5 6
RegisterMission
ÆÆ 
(
ÆÆ 
missions
ÆÆ $
,
ÆÆ$ %
new
ÆÆ& )
MissionDefinition
ÆÆ* ;
{
ÆÆ< =
MissionNumber
ÆÆ> K
=
ÆÆL M
$num
ÆÆN P
,
ÆÆP Q 
ObjectiveCardCount
ÆÆR d
=
ÆÆe f!
FourObjectivesCount
ÆÆg z
,
ÆÆz {
Tokens
ØØ 
=
ØØ 
Array
ØØ 
.
ØØ 
Empty
ØØ $
<
ØØ$ % 
ObjectiveTokenType
ØØ% 7
>
ØØ7 8
(
ØØ8 9
)
ØØ9 :
,
ØØ: ;
CommunicationRule
ØØ< M
=
ØØN O#
CommunicationRuleType
ØØP e
.
ØØe f
Standard
ØØf n
,
ØØn o
SpecialRule
∞∞ 
=
∞∞ $
SpecialMissionRuleType
∞∞ 4
.
∞∞4 5
None
∞∞5 9
,
∞∞9 :
Description
∞∞; F
=
∞∞G H"
Mission10Description
∞∞I ]
}
∞∞^ _
)
∞∞_ `
;
∞∞` a
RegisterMission
±± 
(
±± 
missions
±± $
,
±±$ %
new
±±& )
MissionDefinition
±±* ;
{
±±< =
MissionNumber
±±> K
=
±±L M
$num
±±N P
,
±±P Q 
ObjectiveCardCount
±±R d
=
±±e f!
FourObjectivesCount
±±g z
,
±±z {
Tokens
≤≤ 
=
≤≤ 
Array
≤≤ 
.
≤≤ 

AsReadOnly
≤≤ )
(
≤≤) *
new
≤≤* -
[
≤≤- .
]
≤≤. /
{
≤≤0 1 
ObjectiveTokenType
≤≤2 D
.
≤≤D E
OrderOne
≤≤E M
}
≤≤N O
)
≤≤O P
,
≤≤P Q
CommunicationRule
≥≥ !
=
≥≥" ##
CommunicationRuleType
≥≥$ 9
.
≥≥9 :
Standard
≥≥: B
,
≥≥B C
SpecialRule
¥¥ 
=
¥¥ $
SpecialMissionRuleType
¥¥ 4
.
¥¥4 5*
M11_CaptainSilencesOnePlayer
¥¥5 Q
,
¥¥Q R
Description
µµ 
=
µµ "
Mission11Description
µµ 2
}
µµ3 4
)
µµ4 5
;
µµ5 6
RegisterMission
∂∂ 
(
∂∂ 
missions
∂∂ $
,
∂∂$ %
new
∂∂& )
MissionDefinition
∂∂* ;
{
∂∂< =
MissionNumber
∂∂> K
=
∂∂L M
$num
∂∂N P
,
∂∂P Q 
ObjectiveCardCount
∂∂R d
=
∂∂e f!
FourObjectivesCount
∂∂g z
,
∂∂z {
Tokens
∑∑ 
=
∑∑ 
Array
∑∑ 
.
∑∑ 

AsReadOnly
∑∑ )
(
∑∑) *
new
∑∑* -
[
∑∑- .
]
∑∑. /
{
∑∑0 1 
ObjectiveTokenType
∑∑2 D
.
∑∑D E
Omega
∑∑E J
}
∑∑K L
)
∑∑L M
,
∑∑M N
CommunicationRule
∏∏ !
=
∏∏" ##
CommunicationRuleType
∏∏$ 9
.
∏∏9 :
Standard
∏∏: B
,
∏∏B C
SpecialRule
∏∏D O
=
∏∏P Q$
SpecialMissionRuleType
∏∏R h
.
∏∏h i
None
∏∏i m
,
∏∏m n
Description
ππ 
=
ππ "
Mission12Description
ππ 2
}
ππ3 4
)
ππ4 5
;
ππ5 6
RegisterMission
∫∫ 
(
∫∫ 
missions
∫∫ $
,
∫∫$ %
new
∫∫& )
MissionDefinition
∫∫* ;
{
∫∫< =
MissionNumber
∫∫> K
=
∫∫L M
$num
∫∫N P
,
∫∫P Q 
ObjectiveCardCount
∫∫R d
=
∫∫e f!
ZeroObjectivesCount
∫∫g z
,
∫∫z {
Tokens
ªª 
=
ªª 
Array
ªª 
.
ªª 
Empty
ªª $
<
ªª$ % 
ObjectiveTokenType
ªª% 7
>
ªª7 8
(
ªª8 9
)
ªª9 :
,
ªª: ;
CommunicationRule
ªª< M
=
ªªN O#
CommunicationRuleType
ªªP e
.
ªªe f
Standard
ªªf n
,
ªªn o
SpecialRule
ºº 
=
ºº $
SpecialMissionRuleType
ºº 4
.
ºº4 5.
 M13_WinTrickWithEverySpecialCard
ºº5 U
,
ººU V
Description
ΩΩ 
=
ΩΩ "
Mission13Description
ΩΩ 2
}
ΩΩ3 4
)
ΩΩ4 5
;
ΩΩ5 6
RegisterMission
ææ 
(
ææ 
missions
ææ $
,
ææ$ %
new
ææ& )
MissionDefinition
ææ* ;
{
ææ< =
MissionNumber
ææ> K
=
ææL M
$num
ææN P
,
ææP Q 
ObjectiveCardCount
ææR d
=
ææe f!
FourObjectivesCount
ææg z
,
ææz {
Tokens
øø 
=
øø 
Array
øø 
.
øø 

AsReadOnly
øø )
(
øø) *
new
øø* -
[
øø- .
]
øø. /
{
øø0 1 
ObjectiveTokenType
øø2 D
.
øøD E
ArrowOne
øøE M
,
øøM N 
ObjectiveTokenType
øøO a
.
øøa b
ArrowTwo
øøb j
,
øøj k 
ObjectiveTokenType
¿¿ &
.
¿¿& '

ArrowThree
¿¿' 1
}
¿¿2 3
)
¿¿3 4
,
¿¿4 5
CommunicationRule
¿¿6 G
=
¿¿H I#
CommunicationRuleType
¿¿J _
.
¿¿_ `
Interference
¿¿` l
,
¿¿l m
SpecialRule
¡¡ 
=
¡¡ $
SpecialMissionRuleType
¡¡ 4
.
¡¡4 5
None
¡¡5 9
,
¡¡9 :
Description
¬¬ 
=
¬¬ "
Mission14Description
¬¬ 2
}
¬¬3 4
)
¬¬4 5
;
¬¬5 6
RegisterMission
√√ 
(
√√ 
missions
√√ $
,
√√$ %
new
√√& )
MissionDefinition
√√* ;
{
√√< =
MissionNumber
√√> K
=
√√L M
$num
√√N P
,
√√P Q 
ObjectiveCardCount
√√R d
=
√√e f!
FourObjectivesCount
√√g z
,
√√z {
Tokens
ƒƒ 
=
ƒƒ 
Array
ƒƒ 
.
ƒƒ 

AsReadOnly
ƒƒ )
(
ƒƒ) *
new
ƒƒ* -
[
ƒƒ- .
]
ƒƒ. /
{
ƒƒ0 1 
ObjectiveTokenType
ƒƒ2 D
.
ƒƒD E
OrderOne
ƒƒE M
,
ƒƒM N 
ObjectiveTokenType
ƒƒO a
.
ƒƒa b
OrderTwo
ƒƒb j
,
ƒƒj k 
ObjectiveTokenType
≈≈ &
.
≈≈& '

OrderThree
≈≈' 1
,
≈≈1 2 
ObjectiveTokenType
≈≈3 E
.
≈≈E F
	OrderFour
≈≈F O
}
≈≈P Q
)
≈≈Q R
,
≈≈R S
CommunicationRule
∆∆ !
=
∆∆" ##
CommunicationRuleType
∆∆$ 9
.
∆∆9 :
Standard
∆∆: B
,
∆∆B C
SpecialRule
∆∆D O
=
∆∆P Q$
SpecialMissionRuleType
∆∆R h
.
∆∆h i
None
∆∆i m
,
∆∆m n
Description
«« 
=
«« "
Mission15Description
«« 2
}
««3 4
)
««4 5
;
««5 6
RegisterMission
»» 
(
»» 
missions
»» $
,
»»$ %
new
»»& )
MissionDefinition
»»* ;
{
»»< =
MissionNumber
»»> K
=
»»L M
$num
»»N P
,
»»P Q 
ObjectiveCardCount
»»R d
=
»»e f!
ZeroObjectivesCount
»»g z
,
»»z {
Tokens
…… 
=
…… 
Array
…… 
.
…… 
Empty
…… $
<
……$ % 
ObjectiveTokenType
……% 7
>
……7 8
(
……8 9
)
……9 :
,
……: ;
CommunicationRule
……< M
=
……N O#
CommunicationRuleType
……P e
.
……e f
Standard
……f n
,
……n o
SpecialRule
   
=
   $
SpecialMissionRuleType
   4
.
  4 5*
M16_NoTrickWonWithNumberNine
  5 Q
,
  Q R
Description
ÀÀ 
=
ÀÀ "
Mission16Description
ÀÀ 2
}
ÀÀ3 4
)
ÀÀ4 5
;
ÀÀ5 6
RegisterMission
ÃÃ 
(
ÃÃ 
missions
ÃÃ $
,
ÃÃ$ %
new
ÃÃ& )
MissionDefinition
ÃÃ* ;
{
ÃÃ< =
MissionNumber
ÃÃ> K
=
ÃÃL M
$num
ÃÃN P
,
ÃÃP Q 
ObjectiveCardCount
ÃÃR d
=
ÃÃe f 
TwoObjectivesCount
ÃÃg y
,
ÃÃy z
Tokens
ÕÕ 
=
ÕÕ 
Array
ÕÕ 
.
ÕÕ 
Empty
ÕÕ $
<
ÕÕ$ % 
ObjectiveTokenType
ÕÕ% 7
>
ÕÕ7 8
(
ÕÕ8 9
)
ÕÕ9 :
,
ÕÕ: ;
CommunicationRule
ÕÕ< M
=
ÕÕN O#
CommunicationRuleType
ÕÕP e
.
ÕÕe f
Standard
ÕÕf n
,
ÕÕn o
SpecialRule
ŒŒ 
=
ŒŒ $
SpecialMissionRuleType
ŒŒ 4
.
ŒŒ4 5*
M17_NoTrickWonWithNumberNine
ŒŒ5 Q
,
ŒŒQ R
Description
œœ 
=
œœ "
Mission17Description
œœ 2
}
œœ3 4
)
œœ4 5
;
œœ5 6
RegisterMission
–– 
(
–– 
missions
–– $
,
––$ %
new
––& )
MissionDefinition
––* ;
{
––< =
MissionNumber
––> K
=
––L M
$num
––N P
,
––P Q 
ObjectiveCardCount
––R d
=
––e f!
FiveObjectivesCount
––g z
,
––z {
Tokens
—— 
=
—— 
Array
—— 
.
—— 
Empty
—— $
<
——$ % 
ObjectiveTokenType
——% 7
>
——7 8
(
——8 9
)
——9 :
,
——: ;
CommunicationRule
““ !
=
““" ##
CommunicationRuleType
““$ 9
.
““9 :#
DisruptionUntilTrick2
““: O
,
““O P
SpecialRule
”” 
=
”” $
SpecialMissionRuleType
”” 4
.
””4 5
None
””5 9
,
””9 :
Description
‘‘ 
=
‘‘ "
Mission18Description
‘‘ 2
}
‘‘3 4
)
‘‘4 5
;
‘‘5 6
RegisterMission
’’ 
(
’’ 
missions
’’ $
,
’’$ %
new
’’& )
MissionDefinition
’’* ;
{
’’< =
MissionNumber
’’> K
=
’’L M
$num
’’N P
,
’’P Q 
ObjectiveCardCount
’’R d
=
’’e f!
FiveObjectivesCount
’’g z
,
’’z {
Tokens
÷÷ 
=
÷÷ 
Array
÷÷ 
.
÷÷ 

AsReadOnly
÷÷ )
(
÷÷) *
new
÷÷* -
[
÷÷- .
]
÷÷. /
{
÷÷0 1 
ObjectiveTokenType
÷÷2 D
.
÷÷D E
OrderOne
÷÷E M
}
÷÷N O
)
÷÷O P
,
÷÷P Q
CommunicationRule
◊◊ !
=
◊◊" ##
CommunicationRuleType
◊◊$ 9
.
◊◊9 :#
DisruptionUntilTrick3
◊◊: O
,
◊◊O P
SpecialRule
ÿÿ 
=
ÿÿ $
SpecialMissionRuleType
ÿÿ 4
.
ÿÿ4 5
None
ÿÿ5 9
,
ÿÿ9 :
Description
ŸŸ 
=
ŸŸ "
Mission19Description
ŸŸ 2
}
ŸŸ3 4
)
ŸŸ4 5
;
ŸŸ5 6
RegisterMission
⁄⁄ 
(
⁄⁄ 
missions
⁄⁄ $
,
⁄⁄$ %
new
⁄⁄& )
MissionDefinition
⁄⁄* ;
{
⁄⁄< =
MissionNumber
⁄⁄> K
=
⁄⁄L M
$num
⁄⁄N P
,
⁄⁄P Q 
ObjectiveCardCount
⁄⁄R d
=
⁄⁄e f 
TwoObjectivesCount
⁄⁄g y
,
⁄⁄y z
Tokens
€€ 
=
€€ 
Array
€€ 
.
€€ 
Empty
€€ $
<
€€$ % 
ObjectiveTokenType
€€% 7
>
€€7 8
(
€€8 9
)
€€9 :
,
€€: ;
CommunicationRule
€€< M
=
€€N O#
CommunicationRuleType
€€P e
.
€€e f
Standard
€€f n
,
€€n o
SpecialRule
‹‹ 
=
‹‹ $
SpecialMissionRuleType
‹‹ 4
.
‹‹4 58
*M20_CaptainAssignsAllObjectivesToOnePlayer
‹‹5 _
,
‹‹_ `
Description
›› 
=
›› "
Mission20Description
›› 2
}
››3 4
)
››4 5
;
››5 6
RegisterMission
ﬁﬁ 
(
ﬁﬁ 
missions
ﬁﬁ $
,
ﬁﬁ$ %
new
ﬁﬁ& )
MissionDefinition
ﬁﬁ* ;
{
ﬁﬁ< =
MissionNumber
ﬁﬁ> K
=
ﬁﬁL M
$num
ﬁﬁN P
,
ﬁﬁP Q 
ObjectiveCardCount
ﬁﬁR d
=
ﬁﬁe f!
FiveObjectivesCount
ﬁﬁg z
,
ﬁﬁz {
Tokens
ﬂﬂ 
=
ﬂﬂ 
Array
ﬂﬂ 
.
ﬂﬂ 

AsReadOnly
ﬂﬂ )
(
ﬂﬂ) *
new
ﬂﬂ* -
[
ﬂﬂ- .
]
ﬂﬂ. /
{
ﬂﬂ0 1 
ObjectiveTokenType
ﬂﬂ2 D
.
ﬂﬂD E
OrderOne
ﬂﬂE M
,
ﬂﬂM N 
ObjectiveTokenType
ﬂﬂO a
.
ﬂﬂa b
OrderTwo
ﬂﬂb j
}
ﬂﬂk l
)
ﬂﬂl m
,
ﬂﬂm n
CommunicationRule
‡‡ !
=
‡‡" ##
CommunicationRuleType
‡‡$ 9
.
‡‡9 :
Standard
‡‡: B
,
‡‡B C
SpecialRule
‡‡D O
=
‡‡P Q$
SpecialMissionRuleType
‡‡R h
.
‡‡h i
None
‡‡i m
,
‡‡m n
Description
·· 
=
·· "
Mission21Description
·· 2
}
··3 4
)
··4 5
;
··5 6
RegisterMission
‚‚ 
(
‚‚ 
missions
‚‚ $
,
‚‚$ %
new
‚‚& )
MissionDefinition
‚‚* ;
{
‚‚< =
MissionNumber
‚‚> K
=
‚‚L M
$num
‚‚N P
,
‚‚P Q 
ObjectiveCardCount
‚‚R d
=
‚‚e f!
FiveObjectivesCount
‚‚g z
,
‚‚z {
Tokens
„„ 
=
„„ 
Array
„„ 
.
„„ 

AsReadOnly
„„ )
(
„„) *
new
„„* -
[
„„- .
]
„„. /
{
„„0 1 
ObjectiveTokenType
„„2 D
.
„„D E
ArrowOne
„„E M
,
„„M N 
ObjectiveTokenType
„„O a
.
„„a b
ArrowTwo
„„b j
,
„„j k 
ObjectiveTokenType
‰‰ &
.
‰‰& '

ArrowThree
‰‰' 1
,
‰‰1 2 
ObjectiveTokenType
‰‰3 E
.
‰‰E F
	ArrowFour
‰‰F O
}
‰‰P Q
)
‰‰Q R
,
‰‰R S
CommunicationRule
ÂÂ !
=
ÂÂ" ##
CommunicationRuleType
ÂÂ$ 9
.
ÂÂ9 :
Standard
ÂÂ: B
,
ÂÂB C
SpecialRule
ÂÂD O
=
ÂÂP Q$
SpecialMissionRuleType
ÂÂR h
.
ÂÂh i
None
ÂÂi m
,
ÂÂm n
Description
ÊÊ 
=
ÊÊ "
Mission22Description
ÊÊ 2
}
ÊÊ3 4
)
ÊÊ4 5
;
ÊÊ5 6
RegisterMission
ÁÁ 
(
ÁÁ 
missions
ÁÁ $
,
ÁÁ$ %
new
ÁÁ& )
MissionDefinition
ÁÁ* ;
{
ÁÁ< =
MissionNumber
ÁÁ> K
=
ÁÁL M
$num
ÁÁN P
,
ÁÁP Q 
ObjectiveCardCount
ÁÁR d
=
ÁÁe f!
FiveObjectivesCount
ÁÁg z
,
ÁÁz {
Tokens
ËË 
=
ËË 
Array
ËË 
.
ËË 

AsReadOnly
ËË )
(
ËË) *
new
ËË* -
[
ËË- .
]
ËË. /
{
ËË0 1 
ObjectiveTokenType
ËË2 D
.
ËËD E
OrderOne
ËËE M
,
ËËM N 
ObjectiveTokenType
ËËO a
.
ËËa b
OrderTwo
ËËb j
,
ËËj k 
ObjectiveTokenType
ÈÈ &
.
ÈÈ& '

OrderThree
ÈÈ' 1
,
ÈÈ1 2 
ObjectiveTokenType
ÈÈ3 E
.
ÈÈE F
	OrderFour
ÈÈF O
,
ÈÈO P 
ObjectiveTokenType
ÈÈQ c
.
ÈÈc d
	OrderFive
ÈÈd m
}
ÈÈn o
)
ÈÈo p
,
ÈÈp q
CommunicationRule
ÍÍ !
=
ÍÍ" ##
CommunicationRuleType
ÍÍ$ 9
.
ÍÍ9 :
Standard
ÍÍ: B
,
ÍÍB C
SpecialRule
ÍÍD O
=
ÍÍP Q$
SpecialMissionRuleType
ÍÍR h
.
ÍÍh i
None
ÍÍi m
,
ÍÍm n
Description
ÎÎ 
=
ÎÎ "
Mission23Description
ÎÎ 2
}
ÎÎ3 4
)
ÎÎ4 5
;
ÎÎ5 6
RegisterMission
ÏÏ 
(
ÏÏ 
missions
ÏÏ $
,
ÏÏ$ %
new
ÏÏ& )
MissionDefinition
ÏÏ* ;
{
ÏÏ< =
MissionNumber
ÏÏ> K
=
ÏÏL M
$num
ÏÏN P
,
ÏÏP Q 
ObjectiveCardCount
ÏÏR d
=
ÏÏe f 
SixObjectivesCount
ÏÏg y
,
ÏÏy z
Tokens
ÌÌ 
=
ÌÌ 
Array
ÌÌ 
.
ÌÌ 
Empty
ÌÌ $
<
ÌÌ$ % 
ObjectiveTokenType
ÌÌ% 7
>
ÌÌ7 8
(
ÌÌ8 9
)
ÌÌ9 :
,
ÌÌ: ;
CommunicationRule
ÌÌ< M
=
ÌÌN O#
CommunicationRuleType
ÌÌP e
.
ÌÌe f
Standard
ÌÌf n
,
ÌÌn o
SpecialRule
ÓÓ 
=
ÓÓ $
SpecialMissionRuleType
ÓÓ 4
.
ÓÓ4 5
None
ÓÓ5 9
,
ÓÓ9 :
Description
ÓÓ; F
=
ÓÓG H"
Mission24Description
ÓÓI ]
}
ÓÓ^ _
)
ÓÓ_ `
;
ÓÓ` a
RegisterMission
ÔÔ 
(
ÔÔ 
missions
ÔÔ $
,
ÔÔ$ %
new
ÔÔ& )
MissionDefinition
ÔÔ* ;
{
ÔÔ< =
MissionNumber
ÔÔ> K
=
ÔÔL M
$num
ÔÔN P
,
ÔÔP Q 
ObjectiveCardCount
ÔÔR d
=
ÔÔe f 
SixObjectivesCount
ÔÔg y
,
ÔÔy z
Tokens
 
=
 
Array
 
.
 

AsReadOnly
 )
(
) *
new
* -
[
- .
]
. /
{
0 1 
ObjectiveTokenType
2 D
.
D E
ArrowOne
E M
,
M N 
ObjectiveTokenType
O a
.
a b
ArrowTwo
b j
}
k l
)
l m
,
m n
CommunicationRule
ÒÒ !
=
ÒÒ" ##
CommunicationRuleType
ÒÒ$ 9
.
ÒÒ9 :
Interference
ÒÒ: F
,
ÒÒF G
SpecialRule
ÒÒH S
=
ÒÒT U$
SpecialMissionRuleType
ÒÒV l
.
ÒÒl m
None
ÒÒm q
,
ÒÒq r
Description
ÚÚ 
=
ÚÚ "
Mission25Description
ÚÚ 2
}
ÚÚ3 4
)
ÚÚ4 5
;
ÚÚ5 6
RegisterMission
ÛÛ 
(
ÛÛ 
missions
ÛÛ $
,
ÛÛ$ %
new
ÛÛ& )
MissionDefinition
ÛÛ* ;
{
ÛÛ< =
MissionNumber
ÛÛ> K
=
ÛÛL M
$num
ÛÛN P
,
ÛÛP Q 
ObjectiveCardCount
ÛÛR d
=
ÛÛe f!
ZeroObjectivesCount
ÛÛg z
,
ÛÛz {
Tokens
ÙÙ 
=
ÙÙ 
Array
ÙÙ 
.
ÙÙ 
Empty
ÙÙ $
<
ÙÙ$ % 
ObjectiveTokenType
ÙÙ% 7
>
ÙÙ7 8
(
ÙÙ8 9
)
ÙÙ9 :
,
ÙÙ: ;
CommunicationRule
ÙÙ< M
=
ÙÙN O#
CommunicationRuleType
ÙÙP e
.
ÙÙe f
Standard
ÙÙf n
,
ÙÙn o
SpecialRule
ıı 
=
ıı $
SpecialMissionRuleType
ıı 4
.
ıı4 5+
M26_TwoTricksWonWithNumberOne
ıı5 R
,
ııR S
Description
ˆˆ 
=
ˆˆ "
Mission26Description
ˆˆ 2
}
ˆˆ3 4
)
ˆˆ4 5
;
ˆˆ5 6
RegisterMission
˜˜ 
(
˜˜ 
missions
˜˜ $
,
˜˜$ %
new
˜˜& )
MissionDefinition
˜˜* ;
{
˜˜< =
MissionNumber
˜˜> K
=
˜˜L M
$num
˜˜N P
,
˜˜P Q 
ObjectiveCardCount
˜˜R d
=
˜˜e f"
ThreeObjectivesCount
˜˜g {
,
˜˜{ |
Tokens
¯¯ 
=
¯¯ 
Array
¯¯ 
.
¯¯ 
Empty
¯¯ $
<
¯¯$ % 
ObjectiveTokenType
¯¯% 7
>
¯¯7 8
(
¯¯8 9
)
¯¯9 :
,
¯¯: ;
CommunicationRule
¯¯< M
=
¯¯N O#
CommunicationRuleType
¯¯P e
.
¯¯e f
Standard
¯¯f n
,
¯¯n o
SpecialRule
˘˘ 
=
˘˘ $
SpecialMissionRuleType
˘˘ 4
.
˘˘4 58
*M27_CaptainAssignsAllObjectivesToOnePlayer
˘˘5 _
,
˘˘_ `
Description
˙˙ 
=
˙˙ "
Mission27Description
˙˙ 2
}
˙˙3 4
)
˙˙4 5
;
˙˙5 6
RegisterMission
˚˚ 
(
˚˚ 
missions
˚˚ $
,
˚˚$ %
new
˚˚& )
MissionDefinition
˚˚* ;
{
˚˚< =
MissionNumber
˚˚> K
=
˚˚L M
$num
˚˚N P
,
˚˚P Q 
ObjectiveCardCount
˚˚R d
=
˚˚e f 
SixObjectivesCount
˚˚g y
,
˚˚y z
Tokens
¸¸ 
=
¸¸ 
Array
¸¸ 
.
¸¸ 

AsReadOnly
¸¸ )
(
¸¸) *
new
¸¸* -
[
¸¸- .
]
¸¸. /
{
¸¸0 1 
ObjectiveTokenType
¸¸2 D
.
¸¸D E
OrderOne
¸¸E M
,
¸¸M N 
ObjectiveTokenType
¸¸O a
.
¸¸a b
Omega
¸¸b g
}
¸¸h i
)
¸¸i j
,
¸¸j k
CommunicationRule
˝˝ !
=
˝˝" ##
CommunicationRuleType
˝˝$ 9
.
˝˝9 :#
DisruptionUntilTrick3
˝˝: O
,
˝˝O P
SpecialRule
˛˛ 
=
˛˛ $
SpecialMissionRuleType
˛˛ 4
.
˛˛4 5
None
˛˛5 9
,
˛˛9 :
Description
ˇˇ 
=
ˇˇ "
Mission28Description
ˇˇ 2
}
ˇˇ3 4
)
ˇˇ4 5
;
ˇˇ5 6
RegisterMission
ÄÄ 
(
ÄÄ 
missions
ÄÄ $
,
ÄÄ$ %
new
ÄÄ& )
MissionDefinition
ÄÄ* ;
{
ÄÄ< =
MissionNumber
ÄÄ> K
=
ÄÄL M
$num
ÄÄN P
,
ÄÄP Q 
ObjectiveCardCount
ÄÄR d
=
ÄÄe f!
ZeroObjectivesCount
ÄÄg z
,
ÄÄz {
Tokens
ÅÅ 
=
ÅÅ 
Array
ÅÅ 
.
ÅÅ 
Empty
ÅÅ $
<
ÅÅ$ % 
ObjectiveTokenType
ÅÅ% 7
>
ÅÅ7 8
(
ÅÅ8 9
)
ÅÅ9 :
,
ÅÅ: ;
CommunicationRule
ÅÅ< M
=
ÅÅN O#
CommunicationRuleType
ÅÅP e
.
ÅÅe f
Interference
ÅÅf r
,
ÅÅr s
SpecialRule
ÇÇ 
=
ÇÇ $
SpecialMissionRuleType
ÇÇ 4
.
ÇÇ4 5'
M29_MaxTrickDifferenceTwo
ÇÇ5 N
,
ÇÇN O
Description
ÉÉ 
=
ÉÉ "
Mission29Description
ÉÉ 2
}
ÉÉ3 4
)
ÉÉ4 5
;
ÉÉ5 6
RegisterMission
ÑÑ 
(
ÑÑ 
missions
ÑÑ $
,
ÑÑ$ %
new
ÑÑ& )
MissionDefinition
ÑÑ* ;
{
ÑÑ< =
MissionNumber
ÑÑ> K
=
ÑÑL M
$num
ÑÑN P
,
ÑÑP Q 
ObjectiveCardCount
ÑÑR d
=
ÑÑe f 
SixObjectivesCount
ÑÑg y
,
ÑÑy z
Tokens
ÖÖ 
=
ÖÖ 
Array
ÖÖ 
.
ÖÖ 

AsReadOnly
ÖÖ )
(
ÖÖ) *
new
ÖÖ* -
[
ÖÖ- .
]
ÖÖ. /
{
ÖÖ0 1 
ObjectiveTokenType
ÖÖ2 D
.
ÖÖD E
ArrowOne
ÖÖE M
,
ÖÖM N 
ObjectiveTokenType
ÖÖO a
.
ÖÖa b
ArrowTwo
ÖÖb j
,
ÖÖj k 
ObjectiveTokenType
ÜÜ &
.
ÜÜ& '

ArrowThree
ÜÜ' 1
}
ÜÜ2 3
)
ÜÜ3 4
,
ÜÜ4 5
CommunicationRule
ÜÜ6 G
=
ÜÜH I#
CommunicationRuleType
ÜÜJ _
.
ÜÜ_ `
Standard
ÜÜ` h
,
ÜÜh i
SpecialRule
áá 
=
áá $
SpecialMissionRuleType
áá 4
.
áá4 5
None
áá5 9
,
áá9 :
Description
àà 
=
àà "
Mission30Description
àà 2
}
àà3 4
)
àà4 5
;
àà5 6
RegisterMission
ââ 
(
ââ 
missions
ââ $
,
ââ$ %
new
ââ& )
MissionDefinition
ââ* ;
{
ââ< =
MissionNumber
ââ> K
=
ââL M
$num
ââN P
,
ââP Q 
ObjectiveCardCount
ââR d
=
ââe f 
SixObjectivesCount
ââg y
,
âây z
Tokens
ää 
=
ää 
Array
ää 
.
ää 

AsReadOnly
ää )
(
ää) *
new
ää* -
[
ää- .
]
ää. /
{
ää0 1 
ObjectiveTokenType
ää2 D
.
ääD E
OrderOne
ääE M
,
ääM N 
ObjectiveTokenType
ääO a
.
ääa b
OrderTwo
ääb j
,
ääj k 
ObjectiveTokenType
ãã &
.
ãã& '

OrderThree
ãã' 1
}
ãã2 3
)
ãã3 4
,
ãã4 5
CommunicationRule
ãã6 G
=
ããH I#
CommunicationRuleType
ããJ _
.
ãã_ `
Standard
ãã` h
,
ããh i
SpecialRule
åå 
=
åå $
SpecialMissionRuleType
åå 4
.
åå4 5
None
åå5 9
,
åå9 :
Description
çç 
=
çç "
Mission31Description
çç 2
}
çç3 4
)
çç4 5
;
çç5 6
RegisterMission
éé 
(
éé 
missions
éé $
,
éé$ %
new
éé& )
MissionDefinition
éé* ;
{
éé< =
MissionNumber
éé> K
=
ééL M
$num
ééN P
,
ééP Q 
ObjectiveCardCount
ééR d
=
éée f"
SevenObjectivesCount
éég {
,
éé{ |
Tokens
èè 
=
èè 
Array
èè 
.
èè 
Empty
èè $
<
èè$ % 
ObjectiveTokenType
èè% 7
>
èè7 8
(
èè8 9
)
èè9 :
,
èè: ;
CommunicationRule
èè< M
=
èèN O#
CommunicationRuleType
èèP e
.
èèe f
Standard
èèf n
,
èèn o
SpecialRule
êê 
=
êê $
SpecialMissionRuleType
êê 4
.
êê4 5
None
êê5 9
,
êê9 :
Description
êê; F
=
êêG H"
Mission32Description
êêI ]
}
êê^ _
)
êê_ `
;
êê` a
RegisterMission
ëë 
(
ëë 
missions
ëë $
,
ëë$ %
new
ëë& )
MissionDefinition
ëë* ;
{
ëë< =
MissionNumber
ëë> K
=
ëëL M
$num
ëëN P
,
ëëP Q 
ObjectiveCardCount
ëëR d
=
ëëe f!
ZeroObjectivesCount
ëëg z
,
ëëz {
Tokens
íí 
=
íí 
Array
íí 
.
íí 
Empty
íí $
<
íí$ % 
ObjectiveTokenType
íí% 7
>
íí7 8
(
íí8 9
)
íí9 :
,
íí: ;
CommunicationRule
íí< M
=
ííN O#
CommunicationRuleType
ííP e
.
ííe f
Standard
ííf n
,
íín o
SpecialRule
ìì 
=
ìì $
SpecialMissionRuleType
ìì 4
.
ìì4 5E
7M33_SelectedPlayerWinsExactlyOneTrickWithoutSpecialCard
ìì5 l
,
ììl m
Description
îî 
=
îî "
Mission33Description
îî 2
}
îî3 4
)
îî4 5
;
îî5 6
RegisterMission
ïï 
(
ïï 
missions
ïï $
,
ïï$ %
new
ïï& )
MissionDefinition
ïï* ;
{
ïï< =
MissionNumber
ïï> K
=
ïïL M
$num
ïïN P
,
ïïP Q 
ObjectiveCardCount
ïïR d
=
ïïe f!
ZeroObjectivesCount
ïïg z
,
ïïz {
Tokens
ññ 
=
ññ 
Array
ññ 
.
ññ 
Empty
ññ $
<
ññ$ % 
ObjectiveTokenType
ññ% 7
>
ññ7 8
(
ññ8 9
)
ññ9 :
,
ññ: ;
CommunicationRule
ññ< M
=
ññN O#
CommunicationRuleType
ññP e
.
ññe f
Standard
ññf n
,
ññn o
SpecialRule
óó 
=
óó $
SpecialMissionRuleType
óó 4
.
óó4 5A
3M34_CaptainWinsFirstAndLastTrickAndMaxDifferenceTwo
óó5 h
,
óóh i
Description
òò 
=
òò "
Mission34Description
òò 2
}
òò3 4
)
òò4 5
;
òò5 6
RegisterMission
ôô 
(
ôô 
missions
ôô $
,
ôô$ %
new
ôô& )
MissionDefinition
ôô* ;
{
ôô< =
MissionNumber
ôô> K
=
ôôL M
$num
ôôN P
,
ôôP Q 
ObjectiveCardCount
ôôR d
=
ôôe f"
SevenObjectivesCount
ôôg {
,
ôô{ |
Tokens
öö 
=
öö 
Array
öö 
.
öö 

AsReadOnly
öö )
(
öö) *
new
öö* -
[
öö- .
]
öö. /
{
öö0 1 
ObjectiveTokenType
öö2 D
.
ööD E
ArrowOne
ööE M
,
ööM N 
ObjectiveTokenType
ööO a
.
ööa b
ArrowTwo
ööb j
,
ööj k 
ObjectiveTokenType
õõ &
.
õõ& '

ArrowThree
õõ' 1
}
õõ2 3
)
õõ3 4
,
õõ4 5
CommunicationRule
õõ6 G
=
õõH I#
CommunicationRuleType
õõJ _
.
õõ_ `
Standard
õõ` h
,
õõh i
SpecialRule
úú 
=
úú $
SpecialMissionRuleType
úú 4
.
úú4 5
None
úú5 9
,
úú9 :
Description
úú; F
=
úúG H"
Mission35Description
úúI ]
}
úú^ _
)
úú_ `
;
úú` a
RegisterMission
ùù 
(
ùù 
missions
ùù $
,
ùù$ %
new
ùù& )
MissionDefinition
ùù* ;
{
ùù< =
MissionNumber
ùù> K
=
ùùL M
$num
ùùN P
,
ùùP Q 
ObjectiveCardCount
ùùR d
=
ùùe f"
SevenObjectivesCount
ùùg {
,
ùù{ |
Tokens
ûû 
=
ûû 
Array
ûû 
.
ûû 

AsReadOnly
ûû )
(
ûû) *
new
ûû* -
[
ûû- .
]
ûû. /
{
ûû0 1 
ObjectiveTokenType
ûû2 D
.
ûûD E
OrderOne
ûûE M
,
ûûM N 
ObjectiveTokenType
ûûO a
.
ûûa b
OrderTwo
ûûb j
}
ûûk l
)
ûûl m
,
ûûm n
CommunicationRule
üü !
=
üü" ##
CommunicationRuleType
üü$ 9
.
üü9 :
Standard
üü: B
,
üüB C
SpecialRule
üüD O
=
üüP Q$
SpecialMissionRuleType
üüR h
.
üüh i
None
üüi m
,
üüm n
Description
†† 
=
†† "
Mission36Description
†† 2
}
††3 4
)
††4 5
;
††5 6
RegisterMission
°° 
(
°° 
missions
°° $
,
°°$ %
new
°°& )
MissionDefinition
°°* ;
{
°°< =
MissionNumber
°°> K
=
°°L M
$num
°°N P
,
°°P Q 
ObjectiveCardCount
°°R d
=
°°e f!
FourObjectivesCount
°°g z
,
°°z {
Tokens
¢¢ 
=
¢¢ 
Array
¢¢ 
.
¢¢ 
Empty
¢¢ $
<
¢¢$ % 
ObjectiveTokenType
¢¢% 7
>
¢¢7 8
(
¢¢8 9
)
¢¢9 :
,
¢¢: ;
CommunicationRule
¢¢< M
=
¢¢N O#
CommunicationRuleType
¢¢P e
.
¢¢e f
Standard
¢¢f n
,
¢¢n o
SpecialRule
££ 
=
££ $
SpecialMissionRuleType
££ 4
.
££4 5
None
££5 9
,
££9 :
Description
££; F
=
££G H"
Mission37Description
££I ]
}
££^ _
)
££_ `
;
££` a
RegisterMission
§§ 
(
§§ 
missions
§§ $
,
§§$ %
new
§§& )
MissionDefinition
§§* ;
{
§§< =
MissionNumber
§§> K
=
§§L M
$num
§§N P
,
§§P Q 
ObjectiveCardCount
§§R d
=
§§e f"
EightObjectivesCount
§§g {
,
§§{ |
Tokens
•• 
=
•• 
Array
•• 
.
•• 
Empty
•• $
<
••$ % 
ObjectiveTokenType
••% 7
>
••7 8
(
••8 9
)
••9 :
,
••: ;
CommunicationRule
••< M
=
••N O#
CommunicationRuleType
••P e
.
••e f
Standard
••f n
,
••n o
SpecialRule
¶¶ 
=
¶¶ $
SpecialMissionRuleType
¶¶ 4
.
¶¶4 5
None
¶¶5 9
,
¶¶9 :
Description
¶¶; F
=
¶¶G H"
Mission38Description
¶¶I ]
}
¶¶^ _
)
¶¶_ `
;
¶¶` a
RegisterMission
ßß 
(
ßß 
missions
ßß $
,
ßß$ %
new
ßß& )
MissionDefinition
ßß* ;
{
ßß< =
MissionNumber
ßß> K
=
ßßL M
$num
ßßN P
,
ßßP Q 
ObjectiveCardCount
ßßR d
=
ßße f"
EightObjectivesCount
ßßg {
,
ßß{ |
Tokens
®® 
=
®® 
Array
®® 
.
®® 

AsReadOnly
®® )
(
®®) *
new
®®* -
[
®®- .
]
®®. /
{
®®0 1 
ObjectiveTokenType
®®2 D
.
®®D E
ArrowOne
®®E M
,
®®M N 
ObjectiveTokenType
®®O a
.
®®a b
ArrowTwo
®®b j
,
®®j k 
ObjectiveTokenType
©© &
.
©©& '

ArrowThree
©©' 1
}
©©2 3
)
©©3 4
,
©©4 5
CommunicationRule
©©6 G
=
©©H I#
CommunicationRuleType
©©J _
.
©©_ `
Standard
©©` h
,
©©h i
SpecialRule
™™ 
=
™™ $
SpecialMissionRuleType
™™ 4
.
™™4 5
None
™™5 9
,
™™9 :
Description
™™; F
=
™™G H"
Mission39Description
™™I ]
}
™™^ _
)
™™_ `
;
™™` a
RegisterMission
´´ 
(
´´ 
missions
´´ $
,
´´$ %
new
´´& )
MissionDefinition
´´* ;
{
´´< =
MissionNumber
´´> K
=
´´L M
$num
´´N P
,
´´P Q 
ObjectiveCardCount
´´R d
=
´´e f"
EightObjectivesCount
´´g {
,
´´{ |
Tokens
¨¨ 
=
¨¨ 
Array
¨¨ 
.
¨¨ 

AsReadOnly
¨¨ )
(
¨¨) *
new
¨¨* -
[
¨¨- .
]
¨¨. /
{
¨¨0 1 
ObjectiveTokenType
¨¨2 D
.
¨¨D E
OrderOne
¨¨E M
,
¨¨M N 
ObjectiveTokenType
¨¨O a
.
¨¨a b
OrderTwo
¨¨b j
,
¨¨j k 
ObjectiveTokenType
≠≠ &
.
≠≠& '

OrderThree
≠≠' 1
}
≠≠2 3
)
≠≠3 4
,
≠≠4 5
CommunicationRule
≠≠6 G
=
≠≠H I#
CommunicationRuleType
≠≠J _
.
≠≠_ `
Standard
≠≠` h
,
≠≠h i
SpecialRule
ÆÆ 
=
ÆÆ $
SpecialMissionRuleType
ÆÆ 4
.
ÆÆ4 5
None
ÆÆ5 9
,
ÆÆ9 :
Description
ÆÆ; F
=
ÆÆG H"
Mission40Description
ÆÆI ]
}
ÆÆ^ _
)
ÆÆ_ `
;
ÆÆ` a
RegisterMission
ØØ 
(
ØØ 
missions
ØØ $
,
ØØ$ %
new
ØØ& )
MissionDefinition
ØØ* ;
{
ØØ< =
MissionNumber
ØØ> K
=
ØØL M
$num
ØØN P
,
ØØP Q 
ObjectiveCardCount
ØØR d
=
ØØe f!
ZeroObjectivesCount
ØØg z
,
ØØz {
Tokens
∞∞ 
=
∞∞ 
Array
∞∞ 
.
∞∞ 
Empty
∞∞ $
<
∞∞$ % 
ObjectiveTokenType
∞∞% 7
>
∞∞7 8
(
∞∞8 9
)
∞∞9 :
,
∞∞: ;
CommunicationRule
∞∞< M
=
∞∞N O#
CommunicationRuleType
∞∞P e
.
∞∞e f
Standard
∞∞f n
,
∞∞n o
SpecialRule
±± 
=
±± $
SpecialMissionRuleType
±± 4
.
±±4 5K
=M41_SelectedPlayerWinsOnlyFirstAndLastTrickWithoutSpecialCard
±±5 r
,
±±r s
Description
≤≤ 
=
≤≤ "
Mission41Description
≤≤ 2
}
≤≤3 4
)
≤≤4 5
;
≤≤5 6
RegisterMission
≥≥ 
(
≥≥ 
missions
≥≥ $
,
≥≥$ %
new
≥≥& )
MissionDefinition
≥≥* ;
{
≥≥< =
MissionNumber
≥≥> K
=
≥≥L M
$num
≥≥N P
,
≥≥P Q 
ObjectiveCardCount
≥≥R d
=
≥≥e f!
NineObjectivesCount
≥≥g z
,
≥≥z {
Tokens
¥¥ 
=
¥¥ 
Array
¥¥ 
.
¥¥ 
Empty
¥¥ $
<
¥¥$ % 
ObjectiveTokenType
¥¥% 7
>
¥¥7 8
(
¥¥8 9
)
¥¥9 :
,
¥¥: ;
CommunicationRule
¥¥< M
=
¥¥N O#
CommunicationRuleType
¥¥P e
.
¥¥e f
Standard
¥¥f n
,
¥¥n o
SpecialRule
µµ 
=
µµ $
SpecialMissionRuleType
µµ 4
.
µµ4 5
None
µµ5 9
,
µµ9 :
Description
µµ; F
=
µµG H"
Mission42Description
µµI ]
}
µµ^ _
)
µµ_ `
;
µµ` a
RegisterMission
∂∂ 
(
∂∂ 
missions
∂∂ $
,
∂∂$ %
new
∂∂& )
MissionDefinition
∂∂* ;
{
∂∂< =
MissionNumber
∂∂> K
=
∂∂L M
$num
∂∂N P
,
∂∂P Q 
ObjectiveCardCount
∂∂R d
=
∂∂e f!
NineObjectivesCount
∂∂g z
,
∂∂z {
Tokens
∑∑ 
=
∑∑ 
Array
∑∑ 
.
∑∑ 
Empty
∑∑ $
<
∑∑$ % 
ObjectiveTokenType
∑∑% 7
>
∑∑7 8
(
∑∑8 9
)
∑∑9 :
,
∑∑: ;
CommunicationRule
∑∑< M
=
∑∑N O#
CommunicationRuleType
∑∑P e
.
∑∑e f
Standard
∑∑f n
,
∑∑n o
SpecialRule
∏∏ 
=
∏∏ $
SpecialMissionRuleType
∏∏ 4
.
∏∏4 5
None
∏∏5 9
,
∏∏9 :
Description
∏∏; F
=
∏∏G H"
Mission43Description
∏∏I ]
}
∏∏^ _
)
∏∏_ `
;
∏∏` a
RegisterMission
ππ 
(
ππ 
missions
ππ $
,
ππ$ %
new
ππ& )
MissionDefinition
ππ* ;
{
ππ< =
MissionNumber
ππ> K
=
ππL M
$num
ππN P
,
ππP Q 
ObjectiveCardCount
ππR d
=
ππe f!
ZeroObjectivesCount
ππg z
,
ππz {
Tokens
∫∫ 
=
∫∫ 
Array
∫∫ 
.
∫∫ 
Empty
∫∫ $
<
∫∫$ % 
ObjectiveTokenType
∫∫% 7
>
∫∫7 8
(
∫∫8 9
)
∫∫9 :
,
∫∫: ;
CommunicationRule
∫∫< M
=
∫∫N O#
CommunicationRuleType
∫∫P e
.
∫∫e f
Standard
∫∫f n
,
∫∫n o
SpecialRule
ªª 
=
ªª $
SpecialMissionRuleType
ªª 4
.
ªª4 57
)M44_SpecialCardsWinTricksInAscendingOrder
ªª5 ^
,
ªª^ _
Description
ºº 
=
ºº "
Mission44Description
ºº 2
}
ºº3 4
)
ºº4 5
;
ºº5 6
RegisterMission
ΩΩ 
(
ΩΩ 
missions
ΩΩ $
,
ΩΩ$ %
new
ΩΩ& )
MissionDefinition
ΩΩ* ;
{
ΩΩ< =
MissionNumber
ΩΩ> K
=
ΩΩL M
$num
ΩΩN P
,
ΩΩP Q 
ObjectiveCardCount
ΩΩR d
=
ΩΩe f!
NineObjectivesCount
ΩΩg z
,
ΩΩz {
Tokens
ææ 
=
ææ 
Array
ææ 
.
ææ 

AsReadOnly
ææ )
(
ææ) *
new
ææ* -
[
ææ- .
]
ææ. /
{
ææ0 1 
ObjectiveTokenType
ææ2 D
.
ææD E
ArrowOne
ææE M
,
ææM N 
ObjectiveTokenType
ææO a
.
ææa b
ArrowTwo
ææb j
,
ææj k 
ObjectiveTokenType
øø &
.
øø& '

ArrowThree
øø' 1
}
øø2 3
)
øø3 4
,
øø4 5
CommunicationRule
øø6 G
=
øøH I#
CommunicationRuleType
øøJ _
.
øø_ `
Standard
øø` h
,
øøh i
SpecialRule
¿¿ 
=
¿¿ $
SpecialMissionRuleType
¿¿ 4
.
¿¿4 5
None
¿¿5 9
,
¿¿9 :
Description
¿¿; F
=
¿¿G H"
Mission45Description
¿¿I ]
}
¿¿^ _
)
¿¿_ `
;
¿¿` a
RegisterMission
¡¡ 
(
¡¡ 
missions
¡¡ $
,
¡¡$ %
new
¡¡& )
MissionDefinition
¡¡* ;
{
¡¡< =
MissionNumber
¡¡> K
=
¡¡L M
$num
¡¡N P
,
¡¡P Q 
ObjectiveCardCount
¡¡R d
=
¡¡e f!
ZeroObjectivesCount
¡¡g z
,
¡¡z {
Tokens
¬¬ 
=
¬¬ 
Array
¬¬ 
.
¬¬ 
Empty
¬¬ $
<
¬¬$ % 
ObjectiveTokenType
¬¬% 7
>
¬¬7 8
(
¬¬8 9
)
¬¬9 :
,
¬¬: ;
CommunicationRule
¬¬< M
=
¬¬N O#
CommunicationRuleType
¬¬P e
.
¬¬e f
Standard
¬¬f n
,
¬¬n o
SpecialRule
√√ 
=
√√ $
SpecialMissionRuleType
√√ 4
.
√√4 52
$M46_SeatLeftOfHeartNineWinsAllHearts
√√5 Y
,
√√Y Z
Description
ƒƒ 
=
ƒƒ "
Mission46Description
ƒƒ 2
}
ƒƒ3 4
)
ƒƒ4 5
;
ƒƒ5 6
RegisterMission
≈≈ 
(
≈≈ 
missions
≈≈ $
,
≈≈$ %
new
≈≈& )
MissionDefinition
≈≈* ;
{
≈≈< =
MissionNumber
≈≈> K
=
≈≈L M
$num
≈≈N P
,
≈≈P Q 
ObjectiveCardCount
≈≈R d
=
≈≈e f 
TenObjectivesCount
≈≈g y
,
≈≈y z
Tokens
∆∆ 
=
∆∆ 
Array
∆∆ 
.
∆∆ 
Empty
∆∆ $
<
∆∆$ % 
ObjectiveTokenType
∆∆% 7
>
∆∆7 8
(
∆∆8 9
)
∆∆9 :
,
∆∆: ;
CommunicationRule
∆∆< M
=
∆∆N O#
CommunicationRuleType
∆∆P e
.
∆∆e f
Standard
∆∆f n
,
∆∆n o
SpecialRule
«« 
=
«« $
SpecialMissionRuleType
«« 4
.
««4 5
None
««5 9
,
««9 :
Description
««; F
=
««G H"
Mission47Description
««I ]
}
««^ _
)
««_ `
;
««` a
RegisterMission
»» 
(
»» 
missions
»» $
,
»»$ %
new
»»& )
MissionDefinition
»»* ;
{
»»< =
MissionNumber
»»> K
=
»»L M
$num
»»N P
,
»»P Q 
ObjectiveCardCount
»»R d
=
»»e f"
ThreeObjectivesCount
»»g {
,
»»{ |
Tokens
…… 
=
…… 
Array
…… 
.
…… 

AsReadOnly
…… )
(
……) *
new
……* -
[
……- .
]
……. /
{
……0 1 
ObjectiveTokenType
……2 D
.
……D E
Omega
……E J
}
……K L
)
……L M
,
……M N
CommunicationRule
   !
=
  " ##
CommunicationRuleType
  $ 9
.
  9 :
Standard
  : B
,
  B C
SpecialRule
ÀÀ 
=
ÀÀ $
SpecialMissionRuleType
ÀÀ 4
.
ÀÀ4 54
&M48_OmegaObjectiveCompletedInLastTrick
ÀÀ5 [
,
ÀÀ[ \
Description
ÃÃ 
=
ÃÃ "
Mission48Description
ÃÃ 2
}
ÃÃ3 4
)
ÃÃ4 5
;
ÃÃ5 6
RegisterMission
ÕÕ 
(
ÕÕ 
missions
ÕÕ $
,
ÕÕ$ %
new
ÕÕ& )
MissionDefinition
ÕÕ* ;
{
ÕÕ< =
MissionNumber
ÕÕ> K
=
ÕÕL M
$num
ÕÕN P
,
ÕÕP Q 
ObjectiveCardCount
ÕÕR d
=
ÕÕe f 
TenObjectivesCount
ÕÕg y
,
ÕÕy z
Tokens
ŒŒ 
=
ŒŒ 
Array
ŒŒ 
.
ŒŒ 

AsReadOnly
ŒŒ )
(
ŒŒ) *
new
ŒŒ* -
[
ŒŒ- .
]
ŒŒ. /
{
ŒŒ0 1 
ObjectiveTokenType
ŒŒ2 D
.
ŒŒD E
ArrowOne
ŒŒE M
,
ŒŒM N 
ObjectiveTokenType
ŒŒO a
.
ŒŒa b
ArrowTwo
ŒŒb j
,
ŒŒj k 
ObjectiveTokenType
œœ &
.
œœ& '

ArrowThree
œœ' 1
}
œœ2 3
)
œœ3 4
,
œœ4 5
CommunicationRule
œœ6 G
=
œœH I#
CommunicationRuleType
œœJ _
.
œœ_ `
Standard
œœ` h
,
œœh i
SpecialRule
–– 
=
–– $
SpecialMissionRuleType
–– 4
.
––4 5
None
––5 9
,
––9 :
Description
—— 
=
—— "
Mission49Description
—— 2
}
——3 4
)
——4 5
;
——5 6
RegisterMission
““ 
(
““ 
missions
““ $
,
““$ %
new
““& )
MissionDefinition
““* ;
{
““< =
MissionNumber
““> K
=
““L M
$num
““N P
,
““P Q 
ObjectiveCardCount
““R d
=
““e f!
ZeroObjectivesCount
““g z
,
““z {
Tokens
”” 
=
”” 
Array
”” 
.
”” 
Empty
”” $
<
””$ % 
ObjectiveTokenType
””% 7
>
””7 8
(
””8 9
)
””9 :
,
””: ;
CommunicationRule
””< M
=
””N O#
CommunicationRuleType
””P e
.
””e f
Standard
””f n
,
””n o
SpecialRule
‘‘ 
=
‘‘ $
SpecialMissionRuleType
‘‘ 4
.
‘‘4 5,
M50_SplitTrickWinsDistribution
‘‘5 S
,
‘‘S T
Description
’’ 
=
’’ "
Mission50Description
’’ 2
}
’’3 4
)
’’4 5
;
’’5 6
return
◊◊ 
missions
◊◊ 
;
◊◊ 
}
ÿÿ 	
private
⁄⁄ 
static
⁄⁄ 
void
⁄⁄ 
RegisterMission
⁄⁄ +
(
⁄⁄+ ,

Dictionary
⁄⁄, 6
<
⁄⁄6 7
int
⁄⁄7 :
,
⁄⁄: ;
MissionDefinition
⁄⁄< M
>
⁄⁄M N
missions
⁄⁄O W
,
⁄⁄W X
MissionDefinition
⁄⁄Y j

definition
⁄⁄k u
)
⁄⁄u v
{
€€ 	
missions
‹‹ 
.
‹‹ 
Add
‹‹ 
(
‹‹ 

definition
‹‹ #
.
‹‹# $
MissionNumber
‹‹$ 1
,
‹‹1 2

definition
‹‹3 =
)
‹‹= >
;
‹‹> ?
}
›› 	
}
ﬁﬁ 
}ﬂﬂ …1
cC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Rules\DeckRules.cs
	namespace 	
TrickTakingMissions
 
. 
Rules #
.# $
Rules$ )
{ 
public 

static 
class 
	DeckRules !
{ 
public 
const 
int 
TotalDeckSize &
=' (
$num) +
;+ ,
private 
const 
int 
FirstNormalCardId +
=, -
$num. /
;/ 0
private 
const 
int 
FirstSpecialCardId ,
=- .
$num/ 1
;1 2
private 
const 
int 
MinimumNormalNumber -
=. /
$num0 1
;1 2
private 
const 
int 
MaximumNormalNumber -
=. /
$num0 1
;1 2
private 
const 
int 
SpecialCardNumber +
=, -
$num. /
;/ 0
private 
static 
readonly 
CardSuit  (
[( )
]) *
_normalSuits+ 7
=8 9
{ 	
CardSuit 
. 
Diamond 
, 
CardSuit 
. 
Club 
, 
CardSuit 
. 
Heart 
, 
CardSuit 
. 
Spade 
} 	
;	 

private 
static 
readonly 
SpecialCardSymbol  1
[1 2
]2 3(
_specialSymbolsInCardIdOrder4 P
=Q R
{ 	
SpecialCardSymbol 
. 
Spade #
,# $
SpecialCardSymbol 
. 
Heart #
,# $
SpecialCardSymbol   
.   
Club   "
,  " #
SpecialCardSymbol!! 
.!! 
Diamond!! %
}"" 	
;""	 

private%% 
static%% 
readonly%% 
IReadOnlyList%%  -
<%%- .
Card%%. 2
>%%2 3
_standardDeck%%4 A
=%%B C
CreateStandardDeck%%D V
(%%V W
)%%W X
;%%X Y
public'' 
static'' 
IReadOnlyList'' #
<''# $
Card''$ (
>''( )
CreateStandardDeck''* <
(''< =
)''= >
{(( 	
var)) 
	deckCards)) 
=)) 
new)) 
List))  $
<))$ %
Card))% )
>))) *
())* +
TotalDeckSize))+ 8
)))8 9
;))9 :
AddNormalCards** 
(** 
	deckCards** $
)**$ %
;**% &
AddSpecialCards++ 
(++ 
	deckCards++ %
)++% &
;++& '
return,, 
	deckCards,, 
.,, 

AsReadOnly,, '
(,,' (
),,( )
;,,) *
}-- 	
public// 
static// 
Card// 
GetCardById// &
(//& '
int//' *
idCard//+ 1
)//1 2
{00 	
if11 
(11 
idCard11 
<11 
FirstNormalCardId11 *
||11+ -
idCard11. 4
>115 6
TotalDeckSize117 D
)11D E
{22 
throw33 
new33 '
ArgumentOutOfRangeException33 5
(335 6
nameof336 <
(33< =
idCard33= C
)33C D
)33D E
;33E F
}44 
return66 
_standardDeck66  
[66  !
idCard66! '
-66( )
FirstNormalCardId66* ;
]66; <
;66< =
}77 	
private99 
static99 
void99 
AddNormalCards99 *
(99* +
List99+ /
<99/ 0
Card990 4
>994 5
cards996 ;
)99; <
{:: 	
int;; 

nextCardId;; 
=;; 
FirstNormalCardId;; .
;;;. /
foreach<< 
(<< 
CardSuit<< 
suit<< "
in<<# %
_normalSuits<<& 2
)<<2 3
{== 
for>> 
(>> 
int>> 

cardNumber>> #
=>>$ %
MinimumNormalNumber>>& 9
;>>9 :

cardNumber>>; E
<=>>F H
MaximumNormalNumber>>I \
;>>\ ]

cardNumber>>^ h
++>>h j
)>>j k
{?? 
cards@@ 
.@@ 
Add@@ 
(@@ 
new@@ !
Card@@" &
{AA 
IdCardBB 
=BB  

nextCardIdBB! +
,BB+ ,
SuitCC 
=CC 
suitCC #
,CC# $
NumberDD 
=DD  

cardNumberDD! +
,DD+ ,
SpecialSymbolEE %
=EE& '
SpecialCardSymbolEE( 9
.EE9 :
NoneEE: >
}FF 
)FF 
;FF 

nextCardIdGG 
++GG  
;GG  !
}HH 
}II 
}JJ 	
privateLL 
staticLL 
voidLL 
AddSpecialCardsLL +
(LL+ ,
ListLL, 0
<LL0 1
CardLL1 5
>LL5 6
cardsLL7 <
)LL< =
{MM 	
intNN 

nextCardIdNN 
=NN 
FirstSpecialCardIdNN /
;NN/ 0
foreachOO 
(OO 
SpecialCardSymbolOO &
specialSymbolOO' 4
inOO5 7(
_specialSymbolsInCardIdOrderOO8 T
)OOT U
{PP 
cardsQQ 
.QQ 
AddQQ 
(QQ 
newQQ 
CardQQ "
{RR 
IdCardSS 
=SS 

nextCardIdSS '
,SS' (
SuitTT 
=TT 
CardSuitTT #
.TT# $
SpecialTT$ +
,TT+ ,
NumberUU 
=UU 
SpecialCardNumberUU .
,UU. /
SpecialSymbolVV !
=VV" #
specialSymbolVV$ 1
}WW 
)WW 
;WW 

nextCardIdXX 
++XX 
;XX 
}YY 
}ZZ 	
}[[ 
}\\ ñ
kC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Properties\AssemblyInfo.cs
[ 
assembly 	
:	 

AssemblyTitle 
( 
$str 4
)4 5
]5 6
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
$str 6
)6 7
]7 8
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
]!!) *ñ
tC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Models\TrickPlayValidationResult.cs
	namespace 	
TrickTakingMissions
 
. 
Rules #
.# $
Models$ *
{ 
public 

sealed 
record %
TrickPlayValidationResult 2
{		 
public

 
bool

 
IsLegal

 
{

 
get

 !
;

! "
init

# '
;

' (
}

) *
public $
TrickPlayRejectionReason '
RejectionReason( 7
{8 9
get: =
;= >
init? C
;C D
}E F
public 
static %
TrickPlayValidationResult /
Legal0 5
(5 6
)6 7
{ 	
return 
new %
TrickPlayValidationResult 0
{ 
IsLegal 
= 
true 
, 
RejectionReason 
=  !$
TrickPlayRejectionReason" :
.: ;
None; ?
} 
; 
} 	
public 
static %
TrickPlayValidationResult /
Illegal0 7
(7 8$
TrickPlayRejectionReason8 P
rejectionReasonQ `
)` a
{ 	
return 
new %
TrickPlayValidationResult 0
{ 
IsLegal 
= 
false 
,  
RejectionReason 
=  !
rejectionReason" 1
} 
; 
} 	
} 
}   ∏
kC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Models\TrickPlayContext.cs
	namespace 	
TrickTakingMissions
 
. 
Rules #
.# $
Models$ *
{ 
public 

sealed 
record 
TrickPlayContext )
{		 
public

 
byte

 

PlayerSeat

 
{

  
get

! $
;

$ %
init

& *
;

* +
}

, -
public 
byte 
CurrentTurnSeat #
{$ %
get& )
;) *
init+ /
;/ 0
}1 2
public 
int 
PlayerCount 
{  
get! $
;$ %
init& *
;* +
}, -
public 
IReadOnlyList 
< 
Card !
>! "

PlayerHand# -
{. /
get0 3
;3 4
init5 9
;9 :
}; <
public 
IReadOnlyList 
< 
TrickCardPlay *
>* +#
CurrentTrickPlayedCards, C
{D E
getF I
;I J
initK O
;O P
}Q R
public 
Card 
CandidateCard !
{" #
get$ '
;' (
init) -
;- .
}/ 0
} 
} æ
hC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Models\TrickCardPlay.cs
	namespace 	
TrickTakingMissions
 
. 
Rules #
.# $
Models$ *
{ 
public 

sealed 
record 
TrickCardPlay &
{ 
public 
byte 
Seat 
{ 
get 
; 
init  $
;$ %
}& '
public

 
Card

 
Card

 
{

 
get

 
;

 
init

  $
;

$ %
}

& '
public 
byte 
	PlayOrder 
{ 
get  #
;# $
init% )
;) *
}+ ,
} 
} å
}C:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Models\RadioCommunicationValidationResult.cs
	namespace 	
TrickTakingMissions
 
. 
Rules #
.# $
Models$ *
{ 
public 

sealed 
record .
"RadioCommunicationValidationResult ;
{		 
public

 
bool

 
IsValid

 
{

 
get

 !
;

! "
init

# '
;

' (
}

) *
public -
!RadioCommunicationRejectionReason 0
RejectionReason1 @
{A B
getC F
;F G
initH L
;L M
}N O
public 
RadioTokenPosition !
ResolvedPosition" 2
{3 4
get5 8
;8 9
init: >
;> ?
}@ A
public 
static .
"RadioCommunicationValidationResult 8
Success9 @
(@ A
RadioTokenPositionA S
positionT \
)\ ]
{ 	
return 
new .
"RadioCommunicationValidationResult 9
{ 
IsValid 
= 
true 
, 
RejectionReason 
=  !-
!RadioCommunicationRejectionReason" C
.C D
NoneD H
,H I
ResolvedPosition  
=! "
position# +
} 
; 
} 	
public 
static .
"RadioCommunicationValidationResult 8
Reject9 ?
(? @-
!RadioCommunicationRejectionReason@ a
reasonb h
)h i
{ 	
return 
new .
"RadioCommunicationValidationResult 9
{ 
IsValid 
= 
false 
,  
RejectionReason 
=  !
reason" (
,( )
ResolvedPosition    
=  ! "
RadioTokenPosition  # 5
.  5 6
None  6 :
}!! 
;!! 
}"" 	
}## 
}$$ Ü
tC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Models\RadioCommunicationContext.cs
	namespace 	
TrickTakingMissions
 
. 
Rules #
.# $
Models$ *
{ 
public		 

sealed		 
record		 %
RadioCommunicationContext		 2
{

 
public 
int 
CurrentTrickNumber %
{& '
get( +
;+ ,
init- 1
;1 2
}3 4
public 
bool 
IsTrickInProgress %
{& '
get( +
;+ ,
init- 1
;1 2
}3 4
public 
bool &
HasCommunicatedThisAttempt .
{/ 0
get1 4
;4 5
init6 :
;: ;
}< =
public 
bool 
IsSilencedByCaptain '
{( )
get* -
;- .
init/ 3
;3 4
}5 6
public !
CommunicationRuleType $
CommunicationRule% 6
{7 8
get9 <
;< =
init> B
;B C
}D E
public 
IReadOnlyList 
< 
Card !
>! "
	HandCards# ,
{- .
get/ 2
;2 3
init4 8
;8 9
}: ;
public 
Card 
CardToCommunicate %
{& '
get( +
;+ ,
init- 1
;1 2
}3 4
public 
RadioTokenPosition !
SelectedPosition" 2
{3 4
get5 8
;8 9
init: >
;> ?
}@ A
} 
} Œ	
xC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Models\PlayerRadioCommunicationState.cs
	namespace 	
TrickTakingMissions
 
. 
Rules #
.# $
Models$ *
{ 
public 

sealed 
record )
PlayerRadioCommunicationState 6
{		 
public

 
byte

 
Seat

 
{

 
get

 
;

 
init

  $
;

$ %
}

& '
public 
bool %
HasUsedCommunicationToken -
{. /
get0 3
;3 4
init5 9
;9 :
}; <
public 
bool 
IsSilencedByCaptain '
{( )
get* -
;- .
init/ 3
;3 4
}5 6
public 
Card 
CommunicatedCard $
{% &
get' *
;* +
init, 0
;0 1
}2 3
public 
RadioTokenPosition !
TokenPosition" /
{0 1
get2 5
;5 6
init7 ;
;; <
}= >
} 
} ç
kC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Models\MissionObjective.cs
	namespace 	
TrickTakingMissions
 
. 
Rules #
.# $
Models$ *
{ 
public 

sealed 
record 
MissionObjective )
{		 
public

 
int

 
CardId

 
{

 
get

 
;

  
init

! %
;

% &
}

' (
public 
ObjectiveTokenType !
Token" '
{( )
get* -
;- .
init/ 3
;3 4
}5 6
public 
int 
? 
AssignedSeat  
{! "
get# &
;& '
init( ,
;, -
}. /
public 
bool 

IsRevealed 
{  
get! $
;$ %
init& *
;* +
}, -
=. /
true0 4
;4 5
public 
ObjectiveStatus 
Status %
{& '
get( +
;+ ,
init- 1
;1 2
}3 4
public 
int 
? "
CompletedAtTrickNumber *
{+ ,
get- 0
;0 1
init2 6
;6 7
}8 9
} 
} §
lC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Models\MissionDefinition.cs
	namespace 	
TrickTakingMissions
 
. 
Rules #
.# $
Models$ *
{ 
public		 

sealed		 
record		 
MissionDefinition		 *
{

 
public 
int 
MissionNumber  
{! "
get# &
;& '
init( ,
;, -
}. /
public 
int 
ObjectiveCardCount %
{& '
get( +
;+ ,
init- 1
;1 2
}3 4
public 
IReadOnlyList 
< 
ObjectiveTokenType /
>/ 0
Tokens1 7
{8 9
get: =
;= >
init? C
;C D
}E F
public !
CommunicationRuleType $
CommunicationRule% 6
{7 8
get9 <
;< =
init> B
;B C
}D E
public "
SpecialMissionRuleType %
SpecialRule& 1
{2 3
get4 7
;7 8
init9 =
;= >
}? @
public 
string 
Description !
{" #
get$ '
;' (
init) -
;- .
}/ 0
} 
} ⁄
_C:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Models\Card.cs
	namespace 	
TrickTakingMissions
 
. 
Rules #
.# $
Models$ *
{ 
public 

sealed 
record 
Card 
{		 
public

 
int

 
IdCard

 
{

 
get

 
;

  
init

! %
;

% &
}

' (
public 
CardSuit 
Suit 
{ 
get "
;" #
init$ (
;( )
}* +
public 
int 
Number 
{ 
get 
;  
init! %
;% &
}' (
public 
SpecialCardSymbol  
SpecialSymbol! .
{/ 0
get1 4
;4 5
init6 :
;: ;
}< =
} 
} Æ
rC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Enums\TrickPlayRejectionReason.cs
	namespace 	
TrickTakingMissions
 
. 
Rules #
.# $
Enums$ )
{ 
public 

enum $
TrickPlayRejectionReason (
{ 
None 
= 
$num 
, 
NotPlayerTurn		 
=		 
$num		 
,		 
CardNotInHand

 
=

 
$num

 
,

 
MustFollowLeadSuit 
= 
$num 
, !
TrickAlreadyCompleted 
= 
$num  !
,! "
InvalidPlayContext 
= 
$num 
} 
} ß
pC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Enums\SpecialMissionRuleType.cs
	namespace 	
TrickTakingMissions
 
. 
Rules #
.# $
Enums$ )
{ 
public 

enum "
SpecialMissionRuleType &
{ 
None 
= 
$num 
, %
M05_OnePlayerWinsNoTricks		 !
=		" #
$num		$ %
,		% &%
M09_WinTrickWithNumberOne

 !
=

" #
$num

$ %
,

% &(
M11_CaptainSilencesOnePlayer $
=% &
$num' )
,) *,
 M13_WinTrickWithEverySpecialCard (
=) *
$num+ -
,- .(
M16_NoTrickWonWithNumberNine $
=% &
$num' )
,) *(
M17_NoTrickWonWithNumberNine $
=% &
$num' )
,) *6
*M20_CaptainAssignsAllObjectivesToOnePlayer 2
=3 4
$num5 7
,7 8)
M26_TwoTricksWonWithNumberOne %
=& '
$num( *
,* +6
*M27_CaptainAssignsAllObjectivesToOnePlayer 2
=3 4
$num5 7
,7 8%
M29_MaxTrickDifferenceTwo !
=" #
$num$ &
,& 'C
7M33_SelectedPlayerWinsExactlyOneTrickWithoutSpecialCard ?
=@ A
$numB D
,D E?
3M34_CaptainWinsFirstAndLastTrickAndMaxDifferenceTwo ;
=< =
$num> @
,@ AI
=M41_SelectedPlayerWinsOnlyFirstAndLastTrickWithoutSpecialCard E
=F G
$numH J
,J K5
)M44_SpecialCardsWinTricksInAscendingOrder 1
=2 3
$num4 6
,6 70
$M46_SeatLeftOfHeartNineWinsAllHearts ,
=- .
$num/ 1
,1 22
&M48_OmegaObjectiveCompletedInLastTrick .
=/ 0
$num1 3
,3 4*
M50_SplitTrickWinsDistribution &
=' (
$num) +
} 
} §
kC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Enums\SpecialCardSymbol.cs
	namespace 	
TrickTakingMissions
 
. 
Rules #
.# $
Enums$ )
{ 
public 

enum 
SpecialCardSymbol !
{ 
None 
= 
$num 
, 
Diamond		 
=		 
$num		 
,		 
Club

 
=

 
$num

 
,

 
Heart 
= 
$num 
, 
Spade 
= 
$num 
} 
} Æ
lC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Enums\RadioTokenPosition.cs
	namespace 	
TrickTakingMissions
 
. 
Rules #
.# $
Enums$ )
{ 
public 

enum 
RadioTokenPosition "
{ 
None 
= 
$num 
, 
Highest		 
=		 
$num		 
,		 
Only

 
=

 
$num

 
,

 
Lowest 
= 
$num 
, 
Interference 
= 
$num 
} 
} ä
{C:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Enums\RadioCommunicationRejectionReason.cs
	namespace 	
TrickTakingMissions
 
. 
Rules #
.# $
Enums$ )
{ 
public 

enum -
!RadioCommunicationRejectionReason 1
{ 
None 
= 
$num 
, 
CardNotInHand		 
=		 
$num		 
,		 !
SpecialCardNotAllowed

 
=

 
$num

  !
,

! "*
AlreadyCommunicatedThisAttempt &
=' (
$num) *
,* +.
"CannotCommunicateDuringActiveTrick *
=+ ,
$num- .
,. /
DisruptedUntilTrick 
= 
$num 
,  
SilencedByCaptain 
= 
$num 
, '
InvalidTokenPositionForCard #
=$ %
$num& '
} 
} î
gC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Enums\PassDirection.cs
	namespace 	
TrickTakingMissions
 
. 
Rules #
.# $
Enums$ )
{ 
public 

enum 
PassDirection 
{ 
None 
= 
$num 
, 
Left		 
=		 
$num		 
,		 
Right

 
=

 
$num

 
} 
} Ÿ
lC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Enums\ObjectiveTokenType.cs
	namespace 	
TrickTakingMissions
 
. 
Rules #
.# $
Enums$ )
{ 
public 

enum 
ObjectiveTokenType "
{ 
None 
= 
$num 
, 
OrderOne		 
=		 
$num		 
,		 
OrderTwo

 
=

 
$num

 
,

 

OrderThree 
= 
$num 
, 
	OrderFour 
= 
$num 
, 
	OrderFive 
= 
$num 
, 
ArrowOne 
= 
$num 
, 
ArrowTwo 
= 
$num 
, 

ArrowThree 
= 
$num 
, 
	ArrowFour 
= 
$num 
, 
Omega 
= 
$num 
} 
} °
iC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Enums\ObjectiveStatus.cs
	namespace 	
TrickTakingMissions
 
. 
Rules #
.# $
Enums$ )
{ 
public 

enum 
ObjectiveStatus 
{ 
Pending 
= 
$num 
, 
	Completed		 
=		 
$num		 
,		 
Failed

 
=

 
$num

 
} 
} Æ
nC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Enums\MissionAttemptStatus.cs
	namespace 	
TrickTakingMissions
 
. 
Rules #
.# $
Enums$ )
{ 
public 

enum  
MissionAttemptStatus $
{ 

InProgress 
= 
$num 
, 
	Succeeded		 
=		 
$num		 
,		 
Failed

 
=

 
$num

 
} 
} ®
mC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Enums\MissionAttemptPhase.cs
	namespace 	
TrickTakingMissions
 
. 
Rules #
.# $
Enums$ )
{ 
public 

enum 
MissionAttemptPhase #
{ 
RoleAndPreparation 
= 
$num 
, 
ObjectiveDrafting		 
=		 
$num		 
,		 
DistressSignal

 
=

 
$num

 
,

 
PlayingTricks 
= 
$num 
, !
PausedByDisconnection 
= 
$num  !
,! "
Finished 
= 
$num 
} 
} ¡
lC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Enums\DistressSignalStep.cs
	namespace 	
TrickTakingMissions
 
. 
Rules #
.# $
Enums$ )
{ 
public 

enum 
DistressSignalStep "
{ 
None 
= 
$num 
, 
VotingToUse		 
=		 
$num		 
,		 
VotingDirection

 
=

 
$num

 
,

 
SelectingCard 
= 
$num 
, 
	Completed 
= 
$num 
} 
} ÷
wC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Enums\DisconnectionResolutionOption.cs
	namespace 	
TrickTakingMissions
 
. 
Rules #
.# $
Enums$ )
{ 
public 

enum )
DisconnectionResolutionOption -
{ 
None 
= 
$num 
, *
RestartMissionWithThreePlayers		 &
=		' (
$num		) *
,		* +
ReturnToLobby

 
=

 
$num

 
} 
} ì
oC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Enums\CommunicationRuleType.cs
	namespace 	
TrickTakingMissions
 
. 
Rules #
.# $
Enums$ )
{ 
public 

enum !
CommunicationRuleType %
{ 
Standard 
= 
$num 
, 
Interference		 
=		 
$num		 
,		 !
DisruptionUntilTrick2

 
=

 
$num

  !
,

! "!
DisruptionUntilTrick3 
= 
$num  !
} 
} ï
bC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Enums\CardSuit.cs
	namespace 	
TrickTakingMissions
 
. 
Rules #
.# $
Enums$ )
{ 
public 

enum 
CardSuit 
{ 
Diamond 
= 
$num 
, 
Club		 
=		 
$num		 
,		 
Heart

 
=

 
$num

 
,

 
Spade 
= 
$num 
, 
Special 
= 
$num 
} 
} ≥
wC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Enums\BlindObjectiveCapableResponse.cs
	namespace 	
TrickTakingMissions
 
. 
Rules #
.# $
Enums$ )
{ 
public 

enum )
BlindObjectiveCapableResponse -
{ 
Pending 
= 
$num 
, 
Yes		 
=		 
$num		 
,		 
No

 

=

 
$num

 
} 
} ˝
pC:\Users\oscar\source\repos\TrickTakingMissions\Shared\TrickTakingMissions.Rules\Compatibility\IsExternalInit.cs
	namespace 	
System
 
. 
Runtime 
. 
CompilerServices )
{ 
internal 
static 
class 
IsExternalInit (
{ 
} 
} 