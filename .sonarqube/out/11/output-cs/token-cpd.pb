à
]C:\Users\oscar\source\repos\TrickTakingMissions\Server\Persistence\Properties\AssemblyInfo.cs
[ 
assembly 	
:	 

AssemblyTitle 
( 
$str &
)& '
]' (
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
$str (
)( )
]) *
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
]!!) *∂_
hC:\Users\oscar\source\repos\TrickTakingMissions\Server\Persistence\Repository\PlayerProfileRepository.cs
	namespace 	
Persistence
 
. 

Repository  
{ 
public 

sealed 
class #
PlayerProfileRepository /
:0 1$
IPlayerProfileRepository2 J
{ 
private 
const 
string "
ProfileImageFilePrefix 3
=4 5
$str6 G
;G H
private 
const 
string %
ProfileImageFileExtension 6
=7 8
$str9 ?
;? @
private 
const 
string 
GuidFormatN (
=) *
$str+ .
;. /
private 
const 
string 4
(ReadProfileMetadataEntityFailureTemplate E
=F G
$str n
;n o
private 
const 
string /
#ProfileOwnerNotFoundWarningTemplate @
=A B
$str ^
;^ _
private 
const 
string 4
(SaveProfileMetadataEntityFailureTemplate E
=F G
$str g
;g h
private 
const 
string 6
*SaveProfileMetadataDbUpdateFailureTemplate G
=H I
$str [
;[ \
private   
const   
string   -
!ReadProfileMetadataFailureMessage   >
=  ? @
$str  A l
;  l m
private!! 
const!! 
string!! '
ProfileOwnerNotFoundMessage!! 8
=!!9 :
$str!!; ^
;!!^ _
private"" 
const"" 
string"" -
!SaveProfileMetadataFailureMessage"" >
=""? @
$str""A m
;""m n
private$$ 
readonly$$ 
ILoggerService$$ '
_logger$$( /
;$$/ 0
public&& #
PlayerProfileRepository&& &
(&&& '
ILoggerService&&' 5
logger&&6 <
)&&< =
{'' 	
_logger(( 
=(( 
logger(( 
??(( 
throw((  %
new((& )!
ArgumentNullException((* ?
(((? @
nameof((@ F
(((F G
logger((G M
)((M N
)((N O
;((O P
})) 	
public++ "
PlayerProfileImageData++ %
[++% &
]++& '
GetProfileImages++( 8
(++8 9
int++9 <
[++< =
]++= >
profileOwnerUserIds++? R
)++R S
{,, 	"
PlayerProfileImageData-- "
[--" #
]--# $
profileImages--% 2
;--2 3
try.. 
{// 
using00 
(00 
var00 
context00 "
=00# $
new00% ()
TrickTakingMissionsBDEntities00) F
(00F G
)00G H
)00H I
{11 
List22 
<22 '
StoredProfileImageReference22 4
>224 5
storedProfiles226 D
=22E F
context22G N
.22N O
PlayerProfile22O \
.22\ ]
AsNoTracking22] i
(22i j
)22j k
.33 
Where33 
(33 
profile33 &
=>33' )
profileOwnerUserIds33* =
.33= >
Contains33> F
(33F G
profile33G N
.33N O
IdUser33O U
)33U V
)33V W
.44 
Select44 
(44  
profile44  '
=>44( *
new44+ .'
StoredProfileImageReference44/ J
{55 
IdUser66 "
=66# $
profile66% ,
.66, -
IdUser66- 3
,663 4

AvatarPath77 &
=77' (
profile77) 0
.770 1

AvatarPath771 ;
}88 
)88 
.88 
ToList88 !
(88! "
)88" #
;88# $
profileImages99 !
=99" #
profileOwnerUserIds99$ 7
.997 8
Select998 >
(99> ?
ownerId99? F
=>99G I
new99J M"
PlayerProfileImageData99N d
{:: 
ProfileOwnerUserId;; *
=;;+ ,
ownerId;;- 4
,;;4 5
ProfileImageId<< &
=<<' (
ParseProfileImageId<<) <
(<<< =
storedProfiles<<= K
.== 
FirstOrDefault== +
(==+ ,
profile==, 3
=>==4 6
profile==7 >
.==> ?
IdUser==? E
====F H
ownerId==I P
)==P Q
?==Q R
.==R S

AvatarPath==S ]
)==] ^
}>> 
)>> 
.>> 
ToArray>> 
(>> 
)>>  
;>>  !
}?? 
}@@ 
catchAA 
(AA 
EntityExceptionAA "
exAA# %
)AA% &
{BB 
_loggerCC 
.CC 
ErrorCC 
(CC 
exCC  
,CC  !4
(ReadProfileMetadataEntityFailureTemplateCC" J
,CCJ K
profileOwnerUserIdsCCL _
!=CC` b
nullCCc g
?CCh i
profileOwnerUserIdsCCj }
.CC} ~
Length	CC~ Ñ
:
CCÖ Ü
$num
CCá à
)
CCà â
;
CCâ ä
throwDD 
newDD %
InvalidOperationExceptionDD 3
(DD3 4-
!ReadProfileMetadataFailureMessageDD4 U
,DDU V
exDDW Y
)DDY Z
;DDZ [
}EE 
returnFF 
profileImagesFF  
;FF  !
}GG 	
publicII 
GuidII 
ReplaceProfileImageII '
(II' (
intII( +&
authenticatedAccountUserIdII, F
,IIF G
GuidIIH L
profileImageIdIIM [
)II[ \
{JJ 	
GuidKK 
previousImageIdKK  
;KK  !
tryLL 
{MM 
usingNN 
(NN 
varNN 
contextNN "
=NN# $
newNN% ()
TrickTakingMissionsBDEntitiesNN) F
(NNF G
)NNG H
)NNH I
{OO 
PlayerProfilePP !
profilePP" )
=PP* +
contextPP, 3
.PP3 4
PlayerProfilePP4 A
.PPA B
FindPPB F
(PPF G&
authenticatedAccountUserIdPPG a
)PPa b
;PPb c
ifQQ 
(QQ 
profileQQ 
==QQ  "
nullQQ# '
)QQ' (
{RR 
UserSS 
accountSS $
=SS% &
contextSS' .
.SS. /
UserSS/ 3
.SS3 4
FindSS4 8
(SS8 9&
authenticatedAccountUserIdSS9 S
)SSS T
;SST U
ifTT 
(TT 
accountTT #
==TT$ &
nullTT' +
)TT+ ,
{UU 
_loggerVV #
.VV# $
WarningVV$ +
(VV+ ,/
#ProfileOwnerNotFoundWarningTemplateVV, O
,VVO P&
authenticatedAccountUserIdVVQ k
)VVk l
;VVl m
throwWW !
newWW" %%
InvalidOperationExceptionWW& ?
(WW? @'
ProfileOwnerNotFoundMessageWW@ [
)WW[ \
;WW\ ]
}XX 
profileYY 
=YY  !
newYY" %
PlayerProfileYY& 3
{ZZ 
IdUser[[ "
=[[# $&
authenticatedAccountUserId[[% ?
,[[? @
DisplayName\\ '
=\\( )
account\\* 1
.\\1 2
Username\\2 :
,\\: ;
	CreatedAt]] %
=]]& '
DateTime]]( 0
.]]0 1
UtcNow]]1 7
}^^ 
;^^ 
context__ 
.__  
PlayerProfile__  -
.__- .
Add__. 1
(__1 2
profile__2 9
)__9 :
;__: ;
}`` 
previousImageIdaa #
=aa$ %
ParseProfileImageIdaa& 9
(aa9 :
profileaa: A
.aaA B

AvatarPathaaB L
)aaL M
;aaM N
profilebb 
.bb 

AvatarPathbb &
=bb' ("
ProfileImageFilePrefixbb) ?
+bb@ A
profileImageIdbbB P
.bbP Q
ToStringbbQ Y
(bbY Z
GuidFormatNbbZ e
)bbe f
+bbg h&
ProfileImageFileExtension	bbi Ç
;
bbÇ É
profilecc 
.cc 
	UpdatedAtcc %
=cc& '
DateTimecc( 0
.cc0 1
UtcNowcc1 7
;cc7 8
contextdd 
.dd 
SaveChangesdd '
(dd' (
)dd( )
;dd) *
}ee 
}ff 
catchgg 
(gg 
EntityExceptiongg "
exgg# %
)gg% &
{hh 
_loggerii 
.ii 
Errorii 
(ii 
exii  
,ii  !4
(SaveProfileMetadataEntityFailureTemplateii" J
,iiJ K&
authenticatedAccountUserIdiiL f
)iif g
;iig h
throwjj 
newjj %
InvalidOperationExceptionjj 3
(jj3 4-
!SaveProfileMetadataFailureMessagejj4 U
,jjU V
exjjW Y
)jjY Z
;jjZ [
}kk 
catchll 
(ll 
DbUpdateExceptionll $
exll% '
)ll' (
{mm 
_loggernn 
.nn 
Errornn 
(nn 
exnn  
,nn  !6
*SaveProfileMetadataDbUpdateFailureTemplatenn" L
,nnL M&
authenticatedAccountUserIdnnN h
)nnh i
;nni j
throwoo 
newoo %
InvalidOperationExceptionoo 3
(oo3 4-
!SaveProfileMetadataFailureMessageoo4 U
,ooU V
exooW Y
)ooY Z
;ooZ [
}pp 
returnqq 
previousImageIdqq "
;qq" #
}rr 	
privatett 
statictt 
Guidtt 
ParseProfileImageIdtt /
(tt/ 0
stringtt0 6
storedImageNamett7 F
)ttF G
{uu 	
Guidvv 
profileImageIdvv 
=vv  !
Guidvv" &
.vv& '
Emptyvv' ,
;vv, -
boolww 
hasExpectedShapeww !
=ww" #
storedImageNameww$ 3
!=ww4 6
nullww7 ;
&&ww< >
storedImageNameww? N
.wwN O

StartsWithwwO Y
(wwY Z"
ProfileImageFilePrefixwwZ p
,wwp q
StringComparisonxx  
.xx  !
Ordinalxx! (
)xx( )
&&xx* ,
storedImageNamexx- <
.xx< =
EndsWithxx= E
(xxE F%
ProfileImageFileExtensionxxF _
,xx_ `
StringComparisonxxa q
.xxq r
Ordinalxxr y
)xxy z
;xxz {
ifyy 
(yy 
hasExpectedShapeyy  
)yy  !
{zz 
string{{ 
imageIdentifier{{ &
={{' (
storedImageName{{) 8
.{{8 9
	Substring{{9 B
({{B C"
ProfileImageFilePrefix{{C Y
.{{Y Z
Length{{Z `
,{{` a
storedImageName|| #
.||# $
Length||$ *
-||+ ,"
ProfileImageFilePrefix||- C
.||C D
Length||D J
-||K L%
ProfileImageFileExtension||M f
.||f g
Length||g m
)||m n
;||n o
Guid}} 
.}} 
TryParseExact}} "
(}}" #
imageIdentifier}}# 2
,}}2 3
GuidFormatN}}4 ?
,}}? @
out}}A D
profileImageId}}E S
)}}S T
;}}T U
}~~ 
return 
profileImageId !
;! "
}
ÄÄ 	
private
ÅÅ 
sealed
ÅÅ 
class
ÅÅ )
StoredProfileImageReference
ÅÅ 8
{
ÇÇ 	
public
ÉÉ 
int
ÉÉ 
IdUser
ÉÉ 
{
ÉÉ 
get
ÉÉ  #
;
ÉÉ# $
set
ÉÉ% (
;
ÉÉ( )
}
ÉÉ* +
public
ÑÑ 
string
ÑÑ 

AvatarPath
ÑÑ $
{
ÑÑ% &
get
ÑÑ' *
;
ÑÑ* +
set
ÑÑ, /
;
ÑÑ/ 0
}
ÑÑ1 2
}
ÖÖ 	
}
ÜÜ 
}áá ù 
iC:\Users\oscar\source\repos\TrickTakingMissions\Server\Persistence\Repository\ChatInfractionRepository.cs
	namespace

 	
Persistence


 
.

 

Repository

  
{ 
public 

sealed 
class $
ChatInfractionRepository 0
:1 2%
IChatInfractionRepository3 L
{ 
private 
const 
string &
PersistenceFailureTemplate 7
=8 9
$str: o
;o p
private 
const 
string !
SelectAccountStateSql 2
=3 4
$str r
+s t
$str e
+f g
$str 0
;0 1
private 
const 
string !
UpdateAccountStateSql 2
=3 4
$str u
+v w
$str H
+I J
$str L
+M N
$str N
+O P
$str a
;a b
private 
const 
string !
AcquireAccountLockSql 2
=3 4
$str j
+k l
$str R
+S T
$str ^
;^ _
private 
readonly 
ILoggerService '
_logger( /
;/ 0
public!! $
ChatInfractionRepository!! '
(!!' (
ILoggerService!!( 6
logger!!7 =
)!!= >
{"" 	
_logger## 
=## 
logger## 
??## 
throw##  %
new##& )!
ArgumentNullException##* ?
(##? @
nameof##@ F
(##F G
logger##G M
)##M N
)##N O
;##O P
}$$ 	
public&& &
ChatAccountInfractionState&& )%
GetAccountInfractionState&&* C
(&&C D
int&&D G
accountUserId&&H U
)&&U V
{'' 	&
ChatAccountInfractionState(( &"
accountInfractionState((' =
;((= >
try)) 
{** 
using++ 
(++ 
SqlConnection++ $ 
moderationConnection++% 9
=++: ;(
ModerationDatabaseConnection++< X
.++X Y
Open++Y ]
(++] ^
)++^ _
)++_ `
{,, "
accountInfractionState-- *
=--+ ,
ReadAccountState--- =
(--= > 
moderationConnection--> R
,--R S
null--T X
,--X Y
accountUserId--Z g
)--g h
;--h i
}.. 
}// 
catch00 
(00 
SqlException00 
ex00  "
)00" #
{11 
_logger22 
.22 
Error22 
(22 
ex22  
,22  !&
PersistenceFailureTemplate22" <
,22< =
nameof22> D
(22D E%
GetAccountInfractionState22E ^
)22^ _
)22_ `
;22` a
throw33 
;33 
}44 
return66 "
accountInfractionState66 )
;66) *
}77 	
public99  
ChatInfractionRecord99 #'
RecordChatMessageInfraction99$ ?
(99? @$
ChatInfractionSubmission99@ X$
chatInfractionSubmission99Y q
)99q r
{:: 	 
ChatInfractionRecord;;  "
recordedChatInfraction;;! 7
;;;7 8
try<< 
{== 
using>> 
(>> 
SqlConnection>> $ 
moderationConnection>>% 9
=>>: ;(
ModerationDatabaseConnection>>< X
.>>X Y
Open>>Y ]
(>>] ^
)>>^ _
)>>_ `
using?? 
(?? 
SqlTransaction?? %!
moderationTransaction??& ;
=??< = 
moderationConnection??> R
.??R S
BeginTransaction??S c
(??c d
)??d e
)??e f
{@@ 
AcquireAccountLockAA &
(AA& '!
moderationTransactionAA' <
,AA< =$
chatInfractionSubmissionAA> V
.AAV W
AccountUserIdAAW d
)AAd e
;AAe f"
recordedChatInfractionBB *
=BB+ ,"
RecordUnderAccountLockBB- C
(BBC D!
moderationTransactionBBD Y
,BBY Z$
chatInfractionSubmissionBB[ s
)BBs t
;BBt u!
moderationTransactionCC )
.CC) *
CommitCC* 0
(CC0 1
)CC1 2
;CC2 3
}DD 
}EE 
catchFF 
(FF 
SqlExceptionFF 
exFF  "
)FF" #
{GG 
_loggerHH 
.HH 
ErrorHH 
(HH 
exHH  
,HH  !&
PersistenceFailureTemplateHH" <
,HH< =
nameofHH> D
(HHD E'
RecordChatMessageInfractionHHE `
)HH` a
)HHa b
;HHb c
throwII 
;II 
}JJ 
catchKK 
(KK %
InvalidOperationExceptionKK ,
exKK- /
)KK/ 0
{LL 
_loggerMM 
.MM 
ErrorMM 
(MM 
exMM  
,MM  !&
PersistenceFailureTemplateMM" <
,MM< =
nameofMM> D
(MMD E'
RecordChatMessageInfractionMME `
)MM` a
)MMa b
;MMb c
throwNN 
;NN 
}OO 
returnQQ "
recordedChatInfractionQQ )
;QQ) *
}RR 	
privateTT 
staticTT  
ChatInfractionRecordTT +"
RecordUnderAccountLockTT, B
(TTB C
SqlTransactionTTC Q!
moderationTransactionTTR g
,TTg h$
ChatInfractionSubmissionUU $$
chatInfractionSubmissionUU% =
)UU= >
{VV 	$
EnsureAccountStateExistsWW $
(WW$ %!
moderationTransactionWW% :
,WW: ;$
chatInfractionSubmissionWW< T
.WWT U
AccountUserIdWWU b
)WWb c
;WWc d&
ChatAccountInfractionStateXX &"
accountInfractionStateXX' =
=XX> ?
ReadAccountStateXX@ P
(XXP Q!
moderationTransactionYY %
.YY% &

ConnectionYY& 0
,YY0 1!
moderationTransactionYY2 G
,YYG H$
chatInfractionSubmissionYYI a
.YYa b
AccountUserIdYYb o
)YYo p
;YYp q
DateTimeZZ 
evaluatedAtUtcZZ #
=ZZ$ %
ReadDatabaseUtcTimeZZ& 9
(ZZ9 :!
moderationTransactionZZ: O
)ZZO P
;ZZP Q
ChatInfractionRules[[ 
.[[  
ResetExpiredCycle[[  1
([[1 2"
accountInfractionState[[2 H
,[[H I
evaluatedAtUtc[[J X
)[[X Y
;[[Y Z 
ChatInfractionRecord\\  "
recordedChatInfraction\\! 7
=\\8 9"
ReadPreviousSubmission\\: P
(\\P Q!
moderationTransaction]] %
,]]% &$
chatInfractionSubmission]]' ?
)]]? @
;]]@ A"
recordedChatInfraction^^ "
.^^" #"
AccountInfractionState^^# 9
=^^: ;"
accountInfractionState^^< R
;^^R S
if__ 
(__ 
!__ "
recordedChatInfraction__ '
.__' (+
IsRepeatedChatMessageSubmission__( G
&&__H J
!`` 
ChatInfractionRules`` $
.``$ %
IsAccountBanned``% 4
(``4 5"
accountInfractionState``5 K
,``K L
evaluatedAtUtc``M [
)``[ \
)``\ ]
{aa 
ChatInfractionRulesbb #
.bb# $"
ApplyMessageInfractionbb$ :
(bb: ;"
accountInfractionStatebb; Q
,bbQ R$
chatInfractionSubmissioncc ,
.cc, -&
DetectedInfractionCategorycc- G
,ccG H
evaluatedAtUtcccI W
)ccW X
;ccX Y"
recordedChatInfractiondd &
.dd& '*
CurrentMessageInfractionPointsdd' E
=ddF G
ChatInfractionRulesddH [
.dd[ \&
GetMessageInfractionPointsdd\ v
(ddv w$
chatInfractionSubmissionee ,
.ee, -&
DetectedInfractionCategoryee- G
)eeG H
;eeH I
InsertSubmissionff  
(ff  !!
moderationTransactionff! 6
,ff6 7$
chatInfractionSubmissionff8 P
,ffP Q"
recordedChatInfractionffR h
)ffh i
;ffi j
}gg "
recordedChatInfractionii "
.ii" #
IsAccountBannedii# 2
=ii3 4
ChatInfractionRulesii5 H
.iiH I
IsAccountBannediiI X
(iiX Y"
accountInfractionStatejj &
,jj& '
evaluatedAtUtcjj( 6
)jj6 7
;jj7 8
SaveAccountStatekk 
(kk !
moderationTransactionkk 2
,kk2 3$
chatInfractionSubmissionkk4 L
.kkL M
AccountUserIdkkM Z
,kkZ ["
accountInfractionStatekk\ r
)kkr s
;kks t
ifll 
(ll "
accountInfractionStatell &
.ll& '*
IsChatAccountPermanentlyBannedll' E
)llE F
{mm )
BlockedAccountEmailRepositorynn -
.nn- .
BlockAccountEmailnn. ?
(nn? @!
moderationTransactionnn@ U
,nnU V$
chatInfractionSubmissionoo ,
.oo, -
AccountUserIdoo- :
)oo: ;
;oo; <
}pp 
returnrr "
recordedChatInfractionrr )
;rr) *
}ss 	
privateuu 
staticuu &
ChatAccountInfractionStateuu 1
ReadAccountStateuu2 B
(uuB C
SqlConnectionuuC P 
moderationConnectionuuQ e
,uue f
SqlTransactionvv !
moderationTransactionvv 0
,vv0 1
intvv2 5
accountUserIdvv6 C
)vvC D
{ww 	&
ChatAccountInfractionStatexx &"
accountInfractionStatexx' =
=xx> ?
newxx@ C&
ChatAccountInfractionStatexxD ^
(xx^ _
)xx_ `
;xx` a
usingyy 
(yy 

SqlCommandyy 
moderationCommandyy /
=yy0 1
newyy2 5

SqlCommandyy6 @
(yy@ A!
SelectAccountStateSqlzz %
,zz% & 
moderationConnectionzz' ;
,zz; <!
moderationTransactionzz= R
)zzR S
)zzS T
{{{ 
moderationCommand|| !
.||! "

Parameters||" ,
.||, -
AddWithValue||- 9
(||9 :
$str||: J
,||J K
accountUserId||L Y
)||Y Z
;||Z [
using}} 
(}} 
SqlDataReader}} $
stateReader}}% 0
=}}1 2
moderationCommand}}3 D
.}}D E
ExecuteReader}}E R
(}}R S
)}}S T
)}}T U
{~~ 
if 
( 
stateReader #
.# $
Read$ (
(( )
)) *
)* +
{
ÄÄ $
accountInfractionState
ÅÅ .
=
ÅÅ/ 0
MapAccountState
ÅÅ1 @
(
ÅÅ@ A
stateReader
ÅÅA L
)
ÅÅL M
;
ÅÅM N
}
ÇÇ 
}
ÉÉ 
}
ÑÑ 
return
ÜÜ $
accountInfractionState
ÜÜ )
;
ÜÜ) *
}
áá 	
private
ââ 
static
ââ (
ChatAccountInfractionState
ââ 1
MapAccountState
ââ2 A
(
ââA B
SqlDataReader
ââB O
stateReader
ââP [
)
ââ[ \
{
ää 	
DateTime
ãã 
?
ãã %
chatAccountBanEndsAtUtc
ãã -
=
ãã. /
null
ãã0 4
;
ãã4 5
if
åå 
(
åå 
!
åå 
stateReader
åå 
.
åå 
IsDBNull
åå %
(
åå% &
$num
åå& '
)
åå' (
)
åå( )
{
çç %
chatAccountBanEndsAtUtc
éé '
=
éé( )
DateTime
éé* 2
.
éé2 3
SpecifyKind
éé3 >
(
éé> ?
stateReader
éé? J
.
ééJ K
GetDateTime
ééK V
(
ééV W
$num
ééW X
)
ééX Y
,
ééY Z
DateTimeKind
éé[ g
.
éég h
Utc
ééh k
)
éék l
;
éél m
}
èè 
return
ëë 
new
ëë (
ChatAccountInfractionState
ëë 1
{
íí -
AccumulatedChatInfractionPoints
ìì /
=
ìì0 1
stateReader
ìì2 =
.
ìì= >
GetInt32
ìì> F
(
ììF G
$num
ììG H
)
ììH I
,
ììI J)
ThreateningChatMessageCount
îî +
=
îî, -
stateReader
îî. 9
.
îî9 :
GetInt32
îî: B
(
îîB C
$num
îîC D
)
îîD E
,
îîE F+
PreviousTemporaryChatBanCount
ïï -
=
ïï. /
stateReader
ïï0 ;
.
ïï; <
GetInt32
ïï< D
(
ïïD E
$num
ïïE F
)
ïïF G
,
ïïG H,
IsChatAccountPermanentlyBanned
ññ .
=
ññ/ 0
stateReader
ññ1 <
.
ññ< =

GetBoolean
ññ= G
(
ññG H
$num
ññH I
)
ññI J
,
ññJ K%
ChatAccountBanEndsAtUtc
óó '
=
óó( )%
chatAccountBanEndsAtUtc
óó* A
}
òò 
;
òò 
}
ôô 	
private
õõ 
static
õõ 
void
õõ  
AcquireAccountLock
õõ .
(
õõ. /
SqlTransaction
õõ/ =#
moderationTransaction
õõ> S
,
õõS T
int
õõU X
accountUserId
õõY f
)
õõf g
{
úú 	
using
ùù 
(
ùù 

SqlCommand
ùù 
moderationCommand
ùù /
=
ùù0 1
new
ùù2 5

SqlCommand
ùù6 @
(
ùù@ A#
AcquireAccountLockSql
ùùA V
,
ùùV W#
moderationTransaction
ûû %
.
ûû% &

Connection
ûû& 0
,
ûû0 1#
moderationTransaction
ûû2 G
)
ûûG H
)
ûûH I
{
üü 
moderationCommand
†† !
.
††! "

Parameters
††" ,
.
††, -
AddWithValue
††- 9
(
††9 :
$str
††: P
,
††P Q
$str
°° ,
+
°°- .
accountUserId
°°/ <
)
°°< =
;
°°= >
moderationCommand
¢¢ !
.
¢¢! "
ExecuteNonQuery
¢¢" 1
(
¢¢1 2
)
¢¢2 3
;
¢¢3 4
}
££ 
}
§§ 	
private
¶¶ 
static
¶¶ 
void
¶¶ &
EnsureAccountStateExists
¶¶ 4
(
¶¶4 5
SqlTransaction
¶¶5 C#
moderationTransaction
¶¶D Y
,
¶¶Y Z
int
¶¶[ ^
accountUserId
¶¶_ l
)
¶¶l m
{
ßß 	
const
®® 
string
®® #
InsertAccountStateSql
®® .
=
®®/ 0
$str
©© m
+
©©n o
$str
™™ ]
;
™™] ^
using
´´ 
(
´´ 

SqlCommand
´´ 
moderationCommand
´´ /
=
´´0 1
new
´´2 5

SqlCommand
´´6 @
(
´´@ A#
InsertAccountStateSql
´´A V
,
´´V W#
moderationTransaction
¨¨ %
.
¨¨% &

Connection
¨¨& 0
,
¨¨0 1#
moderationTransaction
¨¨2 G
)
¨¨G H
)
¨¨H I
{
≠≠ 
moderationCommand
ÆÆ !
.
ÆÆ! "

Parameters
ÆÆ" ,
.
ÆÆ, -
AddWithValue
ÆÆ- 9
(
ÆÆ9 :
$str
ÆÆ: J
,
ÆÆJ K
accountUserId
ÆÆL Y
)
ÆÆY Z
;
ÆÆZ [
moderationCommand
ØØ !
.
ØØ! "
ExecuteNonQuery
ØØ" 1
(
ØØ1 2
)
ØØ2 3
;
ØØ3 4
}
∞∞ 
}
±± 	
private
≥≥ 
static
≥≥ 
DateTime
≥≥ !
ReadDatabaseUtcTime
≥≥  3
(
≥≥3 4
SqlTransaction
≥≥4 B#
moderationTransaction
≥≥C X
)
≥≥X Y
{
¥¥ 	
DateTime
µµ 
evaluatedAtUtc
µµ #
;
µµ# $
using
∂∂ 
(
∂∂ 

SqlCommand
∂∂ 
moderationCommand
∂∂ /
=
∂∂0 1
new
∂∂2 5

SqlCommand
∂∂6 @
(
∂∂@ A
$str
∂∂A Z
,
∂∂Z [#
moderationTransaction
∑∑ %
.
∑∑% &

Connection
∑∑& 0
,
∑∑0 1#
moderationTransaction
∑∑2 G
)
∑∑G H
)
∑∑H I
{
∏∏ 
evaluatedAtUtc
ππ 
=
ππ  
DateTime
ππ! )
.
ππ) *
SpecifyKind
ππ* 5
(
ππ5 6
(
ππ6 7
DateTime
ππ7 ?
)
ππ? @
moderationCommand
ππ@ Q
.
ππQ R
ExecuteScalar
ππR _
(
ππ_ `
)
ππ` a
,
ππa b
DateTimeKind
ππc o
.
ππo p
Utc
ππp s
)
ππs t
;
ππt u
}
∫∫ 
return
ºº 
evaluatedAtUtc
ºº !
;
ºº! "
}
ΩΩ 	
private
øø 
static
øø "
ChatInfractionRecord
øø +$
ReadPreviousSubmission
øø, B
(
øøB C
SqlTransaction
øøC Q#
moderationTransaction
øøR g
,
øøg h&
ChatInfractionSubmission
¿¿ $&
chatInfractionSubmission
¿¿% =
)
¿¿= >
{
¡¡ 	
const
¬¬ 
string
¬¬ !
SelectSubmissionSql
¬¬ ,
=
¬¬- .
$str
¬¬/ q
+
¬¬r s
$str
√√ W
+
√√X Y
$str
ƒƒ F
;
ƒƒF G"
ChatInfractionRecord
≈≈  $
recordedChatInfraction
≈≈! 7
=
≈≈8 9
new
≈≈: ="
ChatInfractionRecord
≈≈> R
(
≈≈R S
)
≈≈S T
;
≈≈T U
using
∆∆ 
(
∆∆ 

SqlCommand
∆∆ 
moderationCommand
∆∆ /
=
∆∆0 1
new
∆∆2 5

SqlCommand
∆∆6 @
(
∆∆@ A!
SelectSubmissionSql
∆∆A T
,
∆∆T U#
moderationTransaction
«« %
.
««% &

Connection
««& 0
,
««0 1#
moderationTransaction
««2 G
)
««G H
)
««H I
{
»» -
AddSubmissionIdentityParameters
…… /
(
……/ 0
moderationCommand
……0 A
,
……A B&
chatInfractionSubmission
……C [
)
……[ \
;
……\ ]
using
   
(
   
SqlDataReader
   $
submissionReader
  % 5
=
  6 7
moderationCommand
  8 I
.
  I J
ExecuteReader
  J W
(
  W X
)
  X Y
)
  Y Z
{
ÀÀ 
if
ÃÃ 
(
ÃÃ 
submissionReader
ÃÃ (
.
ÃÃ( )
Read
ÃÃ) -
(
ÃÃ- .
)
ÃÃ. /
)
ÃÃ/ 0
{
ÕÕ $
recordedChatInfraction
ŒŒ .
.
ŒŒ. /-
IsRepeatedChatMessageSubmission
ŒŒ/ N
=
ŒŒO P
true
ŒŒQ U
;
ŒŒU V$
recordedChatInfraction
œœ .
.
œœ. /1
#HasConflictingChatMessageIdentifier
œœ/ R
=
œœS T
submissionReader
–– ,
.
––, -
	GetString
––- 6
(
––6 7
$num
––7 8
)
––8 9
!=
––: <&
chatInfractionSubmission
––= U
.
––U V&
ChatMessageContentDigest
––V n
;
––n o$
recordedChatInfraction
—— .
.
——. /,
CurrentMessageInfractionPoints
——/ M
=
——N O
submissionReader
——P `
.
——` a
GetInt32
——a i
(
——i j
$num
——j k
)
——k l
;
——l m
}
““ 
}
”” 
}
‘‘ 
return
÷÷ $
recordedChatInfraction
÷÷ )
;
÷÷) *
}
◊◊ 	
private
ŸŸ 
static
ŸŸ 
void
ŸŸ 
InsertSubmission
ŸŸ ,
(
ŸŸ, -
SqlTransaction
ŸŸ- ;#
moderationTransaction
ŸŸ< Q
,
ŸŸQ R&
ChatInfractionSubmission
⁄⁄ $&
chatInfractionSubmission
⁄⁄% =
,
⁄⁄= >"
ChatInfractionRecord
⁄⁄? S$
recordedChatInfraction
⁄⁄T j
)
⁄⁄j k
{
€€ 	
const
‹‹ 
string
‹‹ !
InsertSubmissionSql
‹‹ ,
=
‹‹- .
$str
‹‹/ Z
+
‹‹[ \
$str
›› r
+
››s t
$str
ﬁﬁ A
+
ﬁﬁB C
$str
ﬂﬂ L
;
ﬂﬂL M
using
‡‡ 
(
‡‡ 

SqlCommand
‡‡ 
moderationCommand
‡‡ /
=
‡‡0 1
new
‡‡2 5

SqlCommand
‡‡6 @
(
‡‡@ A!
InsertSubmissionSql
‡‡A T
,
‡‡T U#
moderationTransaction
·· %
.
··% &

Connection
··& 0
,
··0 1#
moderationTransaction
··2 G
)
··G H
)
··H I
{
‚‚ -
AddSubmissionIdentityParameters
„„ /
(
„„/ 0
moderationCommand
„„0 A
,
„„A B&
chatInfractionSubmission
„„C [
)
„„[ \
;
„„\ ]
moderationCommand
‰‰ !
.
‰‰! "

Parameters
‰‰" ,
.
‰‰, -
AddWithValue
‰‰- 9
(
‰‰9 :
$str
‰‰: U
,
‰‰U V&
chatInfractionSubmission
ÂÂ ,
.
ÂÂ, -&
ChatMessageContentDigest
ÂÂ- E
)
ÂÂE F
;
ÂÂF G
moderationCommand
ÊÊ !
.
ÊÊ! "

Parameters
ÊÊ" ,
.
ÊÊ, -
AddWithValue
ÊÊ- 9
(
ÊÊ9 :
$str
ÊÊ: [
,
ÊÊ[ \$
recordedChatInfraction
ÁÁ *
.
ÁÁ* +,
CurrentMessageInfractionPoints
ÁÁ+ I
)
ÁÁI J
;
ÁÁJ K
moderationCommand
ËË !
.
ËË! "
ExecuteNonQuery
ËË" 1
(
ËË1 2
)
ËË2 3
;
ËË3 4
}
ÈÈ 
}
ÍÍ 	
private
ÏÏ 
static
ÏÏ 
void
ÏÏ -
AddSubmissionIdentityParameters
ÏÏ ;
(
ÏÏ; <

SqlCommand
ÏÏ< F
moderationCommand
ÏÏG X
,
ÏÏX Y&
ChatInfractionSubmission
ÌÌ $&
chatInfractionSubmission
ÌÌ% =
)
ÌÌ= >
{
ÓÓ 	
moderationCommand
ÔÔ 
.
ÔÔ 

Parameters
ÔÔ (
.
ÔÔ( )
AddWithValue
ÔÔ) 5
(
ÔÔ5 6
$str
ÔÔ6 F
,
ÔÔF G&
chatInfractionSubmission
ÔÔH `
.
ÔÔ` a
AccountUserId
ÔÔa n
)
ÔÔn o
;
ÔÔo p
moderationCommand
 
.
 

Parameters
 (
.
( )
AddWithValue
) 5
(
5 6
$str
6 P
,
P Q&
chatInfractionSubmission
ÒÒ (
.
ÒÒ( )%
ChatMessageSubmissionId
ÒÒ) @
)
ÒÒ@ A
;
ÒÒA B
}
ÚÚ 	
private
ÙÙ 
static
ÙÙ 
void
ÙÙ 
SaveAccountState
ÙÙ ,
(
ÙÙ, -
SqlTransaction
ÙÙ- ;#
moderationTransaction
ÙÙ< Q
,
ÙÙQ R
int
ÙÙS V
accountUserId
ÙÙW d
,
ÙÙd e(
ChatAccountInfractionState
ıı &$
accountInfractionState
ıı' =
)
ıı= >
{
ˆˆ 	
using
˜˜ 
(
˜˜ 

SqlCommand
˜˜ 
moderationCommand
˜˜ /
=
˜˜0 1
new
˜˜2 5

SqlCommand
˜˜6 @
(
˜˜@ A#
UpdateAccountStateSql
˜˜A V
,
˜˜V W#
moderationTransaction
¯¯ %
.
¯¯% &

Connection
¯¯& 0
,
¯¯0 1#
moderationTransaction
¯¯2 G
)
¯¯G H
)
¯¯H I
{
˘˘ 
moderationCommand
˙˙ !
.
˙˙! "

Parameters
˙˙" ,
.
˙˙, -
AddWithValue
˙˙- 9
(
˙˙9 :
$str
˙˙: J
,
˙˙J K
accountUserId
˙˙L Y
)
˙˙Y Z
;
˙˙Z [
moderationCommand
˚˚ !
.
˚˚! "

Parameters
˚˚" ,
.
˚˚, -
AddWithValue
˚˚- 9
(
˚˚9 :
$str
˚˚: \
,
˚˚\ ]$
accountInfractionState
¸¸ *
.
¸¸* +-
AccumulatedChatInfractionPoints
¸¸+ J
)
¸¸J K
;
¸¸K L
moderationCommand
˝˝ !
.
˝˝! "

Parameters
˝˝" ,
.
˝˝, -
AddWithValue
˝˝- 9
(
˝˝9 :
$str
˝˝: X
,
˝˝X Y$
accountInfractionState
˛˛ *
.
˛˛* +)
ThreateningChatMessageCount
˛˛+ F
)
˛˛F G
;
˛˛G H
moderationCommand
ˇˇ !
.
ˇˇ! "

Parameters
ˇˇ" ,
.
ˇˇ, -
AddWithValue
ˇˇ- 9
(
ˇˇ9 :
$str
ˇˇ: Z
,
ˇˇZ [$
accountInfractionState
ÄÄ *
.
ÄÄ* ++
PreviousTemporaryChatBanCount
ÄÄ+ H
)
ÄÄH I
;
ÄÄI J
moderationCommand
ÅÅ !
.
ÅÅ! "

Parameters
ÅÅ" ,
.
ÅÅ, -
AddWithValue
ÅÅ- 9
(
ÅÅ9 :
$str
ÅÅ: [
,
ÅÅ[ \$
accountInfractionState
ÇÇ *
.
ÇÇ* +,
IsChatAccountPermanentlyBanned
ÇÇ+ I
)
ÇÇI J
;
ÇÇJ K
object
ÉÉ $
chatAccountBanEndValue
ÉÉ -
=
ÉÉ. /
DBNull
ÉÉ0 6
.
ÉÉ6 7
Value
ÉÉ7 <
;
ÉÉ< =
if
ÑÑ 
(
ÑÑ $
accountInfractionState
ÑÑ *
.
ÑÑ* +%
ChatAccountBanEndsAtUtc
ÑÑ+ B
.
ÑÑB C
HasValue
ÑÑC K
)
ÑÑK L
{
ÖÖ $
chatAccountBanEndValue
ÜÜ *
=
ÜÜ+ ,$
accountInfractionState
ÜÜ- C
.
ÜÜC D%
ChatAccountBanEndsAtUtc
ÜÜD [
.
ÜÜ[ \
Value
ÜÜ\ a
;
ÜÜa b
}
áá 
moderationCommand
ââ !
.
ââ! "

Parameters
ââ" ,
.
ââ, -
AddWithValue
ââ- 9
(
ââ9 :
$str
ââ: T
,
ââT U$
chatAccountBanEndValue
ââV l
)
ââl m
;
ââm n
moderationCommand
ää !
.
ää! "
ExecuteNonQuery
ää" 1
(
ää1 2
)
ää2 3
;
ää3 4
}
ãã 
}
åå 	
}
çç 
}éé ƒì
_C:\Users\oscar\source\repos\TrickTakingMissions\Server\Persistence\Repository\UserRepository.cs
	namespace 	
Persistence
 
. 

Repository  
{ 
public 

sealed 
class 
UserRepository &
:' (
IUserRepository) 8
{ 
private 
readonly 
ILoggerService '
_logger( /
;/ 0
private 
const 
string /
#GetUserByEmailEntityFailureTemplate @
=A B
$str N
;N O
private 
const 
string ,
 GetUserByEmailSqlFailureTemplate =
=> ?
$str H
;H I
private 
const 
string ,
 GetUserByIdEntityFailureTemplate =
=> ?
$str T
;T U
private 
const 
string )
GetUserByIdSqlFailureTemplate :
=; <
$str F
;F G
private 
const 
string 2
&GetUserByUsernameEntityFailureTemplate C
=D E
$str \
;\ ]
private 
const 
string /
#GetUserByUsernameSqlFailureTemplate @
=A B
$str   N
;  N O
private"" 
const"" 
string"" 0
$UpdateLastLoginEntityFailureTemplate"" A
=""B C
$str## g
;##g h
private%% 
const%% 
string%% -
!CreateUserDbUpdateFailureTemplate%% >
=%%? @
$str&& Z
;&&Z [
private'' 
const'' 
string'' +
CreateUserEntityFailureTemplate'' <
=''= >
$str(( f
;((f g
private)) 
const)) 
string)) (
CreateUserSqlFailureTemplate)) 9
=)): ;
$str** X
;**X Y
private,, 
const,, 
string,, ,
 DatabaseConnectionFailureMessage,, =
=,,> ?
$str,,@ d
;,,d e
private-- 
const-- 
string-- '
DatabaseQueryFailureMessage-- 8
=--9 :
$str--; e
;--e f
private.. 
const.. 
string.. +
UpdateUserSessionFailureMessage.. <
=..= >
$str..? o
;..o p
private// 
const// 
string// +
InsertUserRecordsFailureMessage// <
=//= >
$str//? l
+//m n
$str00 
;00 
private11 
const11 
string11 ,
 ExecuteInsertQueryFailureMessage11 =
=11> ?
$str11@ q
;11q r
public33 
UserRepository33 
(33 
ILoggerService33 ,
logger33- 3
)333 4
{44 	
_logger55 
=55 
logger55 
??55 
throw55  %
new55& )!
ArgumentNullException55* ?
(55? @
nameof55@ F
(55F G
logger55G M
)55M N
)55N O
;55O P
}66 	
public88 
UserAccount88 
GetUserByEmail88 )
(88) *
string88* 0
email881 6
)886 7
{99 	
UserAccount:: 
foundUserAccount:: (
=::) *
null::+ /
;::/ 0
try<< 
{== 
using>> 
(>> )
TrickTakingMissionsBDEntities>> 4
context>>5 <
=>>= >
new>>? B)
TrickTakingMissionsBDEntities>>C `
(>>` a
)>>a b
)>>b c
{?? 

IQueryable@@ 
<@@ 
User@@ #
>@@# $
query@@% *
=@@+ ,
from@@- 1
user@@2 6
in@@7 9
context@@: A
.@@A B
User@@B F
whereAA- 2
userAA3 7
.AA7 8
EmailAA8 =
==AA> @
emailAAA F
selectBB- 3
userBB4 8
;BB8 9
UserCC 
	foundUserCC "
=CC# $
queryCC% *
.CC* +
FirstOrDefaultCC+ 9
(CC9 :
)CC: ;
;CC; <
ifEE 
(EE 
	foundUserEE !
!=EE" $
nullEE% )
)EE) *
{FF 
foundUserAccountGG (
=GG) *
MapToDomainModelGG+ ;
(GG; <
	foundUserGG< E
)GGE F
;GGF G
}HH 
}II 
}JJ 
catchKK 
(KK 
EntityExceptionKK "
exKK# %
)KK% &
{LL 
_loggerMM 
.MM 
ErrorMM 
(MM 
exMM  
,MM  !/
#GetUserByEmailEntityFailureTemplateMM" E
,MME F
emailMMG L
)MML M
;MMM N
throwNN 
newNN %
InvalidOperationExceptionNN 3
(NN3 4,
 DatabaseConnectionFailureMessageNN4 T
,NNT U
exNNV X
)NNX Y
;NNY Z
}OO 
catchPP 
(PP 
SqlExceptionPP 
exPP  "
)PP" #
{QQ 
_loggerRR 
.RR 
ErrorRR 
(RR 
exRR  
,RR  !,
 GetUserByEmailSqlFailureTemplateRR" B
,RRB C
emailRRD I
)RRI J
;RRJ K
throwSS 
newSS %
InvalidOperationExceptionSS 3
(SS3 4'
DatabaseQueryFailureMessageSS4 O
,SSO P
exSSQ S
)SSS T
;SST U
}TT 
returnVV 
foundUserAccountVV #
;VV# $
}WW 	
publicYY 
UserAccountYY 
GetUserByIdYY &
(YY& '
intYY' *
userIdYY+ 1
)YY1 2
{ZZ 	
UserAccount[[ 
foundUserAccount[[ (
=[[) *
null[[+ /
;[[/ 0
try]] 
{^^ 
using__ 
(__ )
TrickTakingMissionsBDEntities__ 4
context__5 <
=__= >
new__? B)
TrickTakingMissionsBDEntities__C `
(__` a
)__a b
)__b c
{`` 
Useraa 
	foundUseraa "
=aa# $
contextaa% ,
.aa, -
Useraa- 1
.aa1 2
Findaa2 6
(aa6 7
userIdaa7 =
)aa= >
;aa> ?
ifbb 
(bb 
	foundUserbb !
!=bb" $
nullbb% )
)bb) *
{cc 
foundUserAccountdd (
=dd) *
MapToDomainModeldd+ ;
(dd; <
	foundUserdd< E
)ddE F
;ddF G
}ee 
}ff 
}gg 
catchhh 
(hh 
EntityExceptionhh "
exhh# %
)hh% &
{ii 
_loggerjj 
.jj 
Errorjj 
(jj 
exjj  
,jj  !,
 GetUserByIdEntityFailureTemplatejj" B
,jjB C
userIdjjD J
)jjJ K
;jjK L
throwkk 
newkk %
InvalidOperationExceptionkk 3
(kk3 4,
 DatabaseConnectionFailureMessagekk4 T
,kkT U
exkkV X
)kkX Y
;kkY Z
}ll 
catchmm 
(mm 
SqlExceptionmm 
exmm  "
)mm" #
{nn 
_loggeroo 
.oo 
Erroroo 
(oo 
exoo  
,oo  !)
GetUserByIdSqlFailureTemplateoo" ?
,oo? @
userIdooA G
)ooG H
;ooH I
throwpp 
newpp %
InvalidOperationExceptionpp 3
(pp3 4'
DatabaseQueryFailureMessagepp4 O
,ppO P
exppQ S
)ppS T
;ppT U
}qq 
returnss 
foundUserAccountss #
;ss# $
}tt 	
publicvv 
UserAccountvv 
GetUserByUsernamevv ,
(vv, -
stringvv- 3
usernamevv4 <
)vv< =
{ww 	
UserAccountxx 
foundUserAccountxx (
=xx) *
nullxx+ /
;xx/ 0
tryzz 
{{{ 
using|| 
(|| )
TrickTakingMissionsBDEntities|| 4
context||5 <
=||= >
new||? B)
TrickTakingMissionsBDEntities||C `
(||` a
)||a b
)||b c
{}} 

IQueryable~~ 
<~~ 
User~~ #
>~~# $
query~~% *
=~~+ ,
from~~- 1
user~~2 6
in~~7 9
context~~: A
.~~A B
User~~B F
where- 2
user3 7
.7 8
Username8 @
==A C
usernameD L
select
ÄÄ- 3
user
ÄÄ4 8
;
ÄÄ8 9
User
ÅÅ 
	foundUser
ÅÅ "
=
ÅÅ# $
query
ÅÅ% *
.
ÅÅ* +
FirstOrDefault
ÅÅ+ 9
(
ÅÅ9 :
)
ÅÅ: ;
;
ÅÅ; <
if
ÉÉ 
(
ÉÉ 
	foundUser
ÉÉ !
!=
ÉÉ" $
null
ÉÉ% )
)
ÉÉ) *
{
ÑÑ 
foundUserAccount
ÖÖ (
=
ÖÖ) *
MapToDomainModel
ÖÖ+ ;
(
ÖÖ; <
	foundUser
ÖÖ< E
)
ÖÖE F
;
ÖÖF G
}
ÜÜ 
}
áá 
}
àà 
catch
ââ 
(
ââ 
EntityException
ââ "
ex
ââ# %
)
ââ% &
{
ää 
_logger
ãã 
.
ãã 
Error
ãã 
(
ãã 
ex
ãã  
,
ãã  !4
&GetUserByUsernameEntityFailureTemplate
ãã" H
,
ããH I
username
ããJ R
)
ããR S
;
ããS T
throw
åå 
new
åå '
InvalidOperationException
åå 3
(
åå3 4.
 DatabaseConnectionFailureMessage
åå4 T
,
ååT U
ex
ååV X
)
ååX Y
;
ååY Z
}
çç 
catch
éé 
(
éé 
SqlException
éé 
ex
éé  "
)
éé" #
{
èè 
_logger
êê 
.
êê 
Error
êê 
(
êê 
ex
êê  
,
êê  !1
#GetUserByUsernameSqlFailureTemplate
êê" E
,
êêE F
username
êêG O
)
êêO P
;
êêP Q
throw
ëë 
new
ëë '
InvalidOperationException
ëë 3
(
ëë3 4)
DatabaseQueryFailureMessage
ëë4 O
,
ëëO P
ex
ëëQ S
)
ëëS T
;
ëëT U
}
íí 
return
îî 
foundUserAccount
îî #
;
îî# $
}
ïï 	
public
óó 
void
óó 
UpdateLastLogin
óó #
(
óó# $
int
óó$ '
userId
óó( .
)
óó. /
{
òò 	
try
ôô 
{
öö 
using
õõ 
(
õõ +
TrickTakingMissionsBDEntities
õõ 4
context
õõ5 <
=
õõ= >
new
õõ? B+
TrickTakingMissionsBDEntities
õõC `
(
õõ` a
)
õõa b
)
õõb c
{
úú 
User
ùù 
user
ùù 
=
ùù 
context
ùù  '
.
ùù' (
User
ùù( ,
.
ùù, -
Find
ùù- 1
(
ùù1 2
userId
ùù2 8
)
ùù8 9
;
ùù9 :
if
ûû 
(
ûû 
user
ûû 
!=
ûû 
null
ûû  $
)
ûû$ %
{
üü 
user
†† 
.
†† 
LastLoginAt
†† (
=
††) *
DateTime
††+ 3
.
††3 4
UtcNow
††4 :
;
††: ;
context
°° 
.
°°  
SaveChanges
°°  +
(
°°+ ,
)
°°, -
;
°°- .
}
¢¢ 
}
££ 
}
§§ 
catch
•• 
(
•• 
EntityException
•• "
ex
••# %
)
••% &
{
¶¶ 
_logger
ßß 
.
ßß 
Error
ßß 
(
ßß 
ex
ßß  
,
ßß  !2
$UpdateLastLoginEntityFailureTemplate
ßß" F
,
ßßF G
userId
ßßH N
)
ßßN O
;
ßßO P
throw
®® 
new
®® '
InvalidOperationException
®® 3
(
®®3 4-
UpdateUserSessionFailureMessage
®®4 S
,
®®S T
ex
®®U W
)
®®W X
;
®®X Y
}
©© 
}
™™ 	
public
¨¨ 
int
¨¨ 

CreateUser
¨¨ 
(
¨¨ 
UserAccount
¨¨ )
user
¨¨* .
,
¨¨. /
string
¨¨0 6
displayName
¨¨7 B
)
¨¨B C
{
≠≠ 	
if
ÆÆ 
(
ÆÆ 
user
ÆÆ 
==
ÆÆ 
null
ÆÆ 
)
ÆÆ 
{
ØØ 
throw
∞∞ 
new
∞∞ #
ArgumentNullException
∞∞ /
(
∞∞/ 0
nameof
∞∞0 6
(
∞∞6 7
user
∞∞7 ;
)
∞∞; <
)
∞∞< =
;
∞∞= >
}
±± 
int
≥≥ 
createdUserId
≥≥ 
=
≥≥ 
$num
≥≥  !
;
≥≥! "
try
µµ 
{
∂∂ 
using
∑∑ 
(
∑∑ +
TrickTakingMissionsBDEntities
∑∑ 4
context
∑∑5 <
=
∑∑= >
new
∑∑? B+
TrickTakingMissionsBDEntities
∑∑C `
(
∑∑` a
)
∑∑a b
)
∑∑b c
{
∏∏ 
User
ππ 

userEntity
ππ #
=
ππ$ %
new
ππ& )
User
ππ* .
{
∫∫ 
Username
ªª  
=
ªª! "
user
ªª# '
.
ªª' (
Username
ªª( 0
,
ªª0 1
Email
ºº 
=
ºº 
user
ºº  $
.
ºº$ %
Email
ºº% *
,
ºº* +
PasswordHash
ΩΩ $
=
ΩΩ% &
user
ΩΩ' +
.
ΩΩ+ ,
PasswordHash
ΩΩ, 8
,
ΩΩ8 9
Status
ææ 
=
ææ  
user
ææ! %
.
ææ% &
Status
ææ& ,
,
ææ, -
	CreatedAt
øø !
=
øø" #
user
øø$ (
.
øø( )
	CreatedAt
øø) 2
}
¿¿ 
;
¿¿ 
context
¬¬ 
.
¬¬ 
User
¬¬  
.
¬¬  !
Add
¬¬! $
(
¬¬$ %

userEntity
¬¬% /
)
¬¬/ 0
;
¬¬0 1
context
√√ 
.
√√ 
SaveChanges
√√ '
(
√√' (
)
√√( )
;
√√) *
if
≈≈ 
(
≈≈ 
!
≈≈ 
string
≈≈ 
.
≈≈   
IsNullOrWhiteSpace
≈≈  2
(
≈≈2 3
displayName
≈≈3 >
)
≈≈> ?
&&
≈≈@ B
!
≈≈C D
string
≈≈D J
.
≈≈J K
Equals
≈≈K Q
(
≈≈Q R
displayName
≈≈R ]
,
≈≈] ^
user
≈≈_ c
.
≈≈c d
Username
≈≈d l
,
≈≈l m
StringComparison
∆∆ (
.
∆∆( )
Ordinal
∆∆) 0
)
∆∆0 1
)
∆∆1 2
{
«« 
PlayerProfile
»» %
profile
»»& -
=
»». /
context
»»0 7
.
»»7 8
PlayerProfile
»»8 E
.
»»E F
Find
»»F J
(
»»J K

userEntity
»»K U
.
»»U V
IdUser
»»V \
)
»»\ ]
;
»»] ^
if
…… 
(
…… 
profile
…… #
!=
……$ &
null
……' +
)
……+ ,
{
   
profile
ÀÀ #
.
ÀÀ# $
DisplayName
ÀÀ$ /
=
ÀÀ0 1
displayName
ÀÀ2 =
;
ÀÀ= >
context
ÃÃ #
.
ÃÃ# $
SaveChanges
ÃÃ$ /
(
ÃÃ/ 0
)
ÃÃ0 1
;
ÃÃ1 2
}
ÕÕ 
}
ŒŒ 
createdUserId
–– !
=
––" #

userEntity
––$ .
.
––. /
IdUser
––/ 5
;
––5 6
}
—— 
}
““ 
catch
”” 
(
”” 
DbUpdateException
”” $
ex
””% '
)
””' (
{
‘‘ 
_logger
’’ 
.
’’ 
Error
’’ 
(
’’ 
ex
’’  
,
’’  !/
!CreateUserDbUpdateFailureTemplate
’’" C
,
’’C D
user
’’E I
.
’’I J
Username
’’J R
)
’’R S
;
’’S T
throw
÷÷ 
new
÷÷ '
InvalidOperationException
÷÷ 3
(
÷÷3 4-
InsertUserRecordsFailureMessage
÷÷4 S
,
÷÷S T
ex
÷÷U W
)
÷÷W X
;
÷÷X Y
}
◊◊ 
catch
ÿÿ 
(
ÿÿ 
EntityException
ÿÿ "
ex
ÿÿ# %
)
ÿÿ% &
{
ŸŸ 
_logger
⁄⁄ 
.
⁄⁄ 
Error
⁄⁄ 
(
⁄⁄ 
ex
⁄⁄  
,
⁄⁄  !-
CreateUserEntityFailureTemplate
⁄⁄" A
,
⁄⁄A B
user
⁄⁄C G
.
⁄⁄G H
Username
⁄⁄H P
)
⁄⁄P Q
;
⁄⁄Q R
throw
€€ 
new
€€ '
InvalidOperationException
€€ 3
(
€€3 4.
 DatabaseConnectionFailureMessage
€€4 T
,
€€T U
ex
€€V X
)
€€X Y
;
€€Y Z
}
‹‹ 
catch
›› 
(
›› 
SqlException
›› 
ex
››  "
)
››" #
{
ﬁﬁ 
_logger
ﬂﬂ 
.
ﬂﬂ 
Error
ﬂﬂ 
(
ﬂﬂ 
ex
ﬂﬂ  
,
ﬂﬂ  !*
CreateUserSqlFailureTemplate
ﬂﬂ" >
,
ﬂﬂ> ?
user
ﬂﬂ@ D
.
ﬂﬂD E
Username
ﬂﬂE M
)
ﬂﬂM N
;
ﬂﬂN O
throw
‡‡ 
new
‡‡ '
InvalidOperationException
‡‡ 3
(
‡‡3 4.
 ExecuteInsertQueryFailureMessage
‡‡4 T
,
‡‡T U
ex
‡‡V X
)
‡‡X Y
;
‡‡Y Z
}
·· 
return
„„ 
createdUserId
„„  
;
„„  !
}
‰‰ 	
private
ÊÊ 
static
ÊÊ 
UserAccount
ÊÊ "
MapToDomainModel
ÊÊ# 3
(
ÊÊ3 4
User
ÊÊ4 8
entity
ÊÊ9 ?
)
ÊÊ? @
{
ÁÁ 	
return
ËË 
new
ËË 
UserAccount
ËË "
{
ÈÈ 
IdUser
ÍÍ 
=
ÍÍ 
entity
ÍÍ 
.
ÍÍ  
IdUser
ÍÍ  &
,
ÍÍ& '
Username
ÎÎ 
=
ÎÎ 
entity
ÎÎ !
.
ÎÎ! "
Username
ÎÎ" *
,
ÎÎ* +
Email
ÏÏ 
=
ÏÏ 
entity
ÏÏ 
.
ÏÏ 
Email
ÏÏ $
,
ÏÏ$ %
PasswordHash
ÌÌ 
=
ÌÌ 
entity
ÌÌ %
.
ÌÌ% &
PasswordHash
ÌÌ& 2
,
ÌÌ2 3
Status
ÓÓ 
=
ÓÓ 
entity
ÓÓ 
.
ÓÓ  
Status
ÓÓ  &
,
ÓÓ& '
	CreatedAt
ÔÔ 
=
ÔÔ 
entity
ÔÔ "
.
ÔÔ" #
	CreatedAt
ÔÔ# ,
,
ÔÔ, -
LastLoginAt
 
=
 
entity
 $
.
$ %
LastLoginAt
% 0
}
ÒÒ 
;
ÒÒ 
}
ÚÚ 	
}
ÛÛ 
}ÙÙ ≈
QC:\Users\oscar\source\repos\TrickTakingMissions\Server\Persistence\UserPartial.cs
	namespace 	
Persistence
 
. 
Entities 
{ 
public 

partial 
class 
User 
{ 
public 
int 
Position 
{ 
get !
;! "
set# &
;& '
}( )
} 
} Ÿ´
eC:\Users\oscar\source\repos\TrickTakingMissions\Server\Persistence\Repository\FriendshipRepository.cs
	namespace 	
Persistence
 
. 

Repository  
{ 
public 

sealed 
class  
FriendshipRepository ,
:- .!
IFriendshipRepository/ D
{ 
private 
const 
byte #
PendingFriendshipStatus 2
=3 4
$num5 6
;6 7
private 
const 
byte $
AcceptedFriendshipStatus 3
=4 5
$num6 7
;7 8
private 
const 
byte 
OnlineUserStatus +
=, -
$num. /
;/ 0
private 
const 
string .
"BlockPlayerDbUpdateFailureTemplate ?
=@ A
$str ^
;^ _
private 
const 
string ,
 BlockPlayerEntityFailureTemplate =
=> ?
$str j
;j k
private 
const 
string )
BlockPlayerSqlFailureTemplate :
=; <
$str \
;\ ]
private 
const 
string 6
*CreateFriendRequestDbUpdateFailureTemplate G
=H I
$str u
;u v
private 
const 
string 4
(CreateFriendRequestEntityFailureTemplate E
=F G
$str   k
+  l m
$str!! $
;!!$ %
private"" 
const"" 
string"" 1
%CreateFriendRequestSqlFailureTemplate"" B
=""C D
$str## t
;##t u
private%% 
const%% 
string%% 3
'DeleteFriendshipDbUpdateFailureTemplate%% D
=%%E F
$str&& r
;&&r s
private'' 
const'' 
string'' 1
%DeleteFriendshipEntityFailureTemplate'' B
=''C D
$str(( j
+((k l
$str)) "
;))" #
private** 
const** 
string** .
"DeleteFriendshipSqlFailureTemplate** ?
=**@ A
$str++ f
+++g h
$str,, "
;,," #
private.. 
const.. 
string.. .
"GetFriendshipEntityFailureTemplate.. ?
=..@ A
$str// q
+//r s
$str00 "
;00" #
private11 
const11 
string11 +
GetFriendshipSqlFailureTemplate11 <
=11= >
$str22 c
+22d e
$str33 "
;33" #
private55 
const55 
string55 /
#GetFriendsListEntityFailureTemplate55 @
=55A B
$str66 _
;66_ `
private77 
const77 
string77 ,
 GetFriendsListSqlFailureTemplate77 =
=77> ?
$str88 ]
;88] ^
private:: 
const:: 
string:: 3
'GetPendingRequestsEntityFailureTemplate:: D
=::E F
$str;; j
;;;j k
private<< 
const<< 
string<< 0
$GetPendingRequestsSqlFailureTemplate<< A
=<<B C
$str== \
;==\ ]
private?? 
const?? 
string?? 0
$GetSentRequestsEntityFailureTemplate?? A
=??B C
$str@@ g
;@@g h
privateAA 
constAA 
stringAA -
!GetSentRequestsSqlFailureTemplateAA >
=AA? @
$strBB Y
;BBY Z
privateDD 
constDD 
stringDD 0
$IsPlayerBlockedEntityFailureTemplateDD A
=DDB C
$strEE q
+EEr s
$strFF 
;FF  
privateGG 
constGG 
stringGG -
!IsPlayerBlockedSqlFailureTemplateGG >
=GG? @
$strHH t
;HHt u
privateJJ 
constJJ 
stringJJ 3
'RemoveFriendshipDbUpdateFailureTemplateJJ D
=JJE F
$strKK r
;KKr s
privateLL 
constLL 
stringLL 1
%RemoveFriendshipEntityFailureTemplateLL B
=LLC D
$strMM j
+MMk l
$strNN "
;NN" #
privateOO 
constOO 
stringOO .
"RemoveFriendshipSqlFailureTemplateOO ?
=OO@ A
$strPP h
+PPi j
$strQQ "
;QQ" #
privateSS 
constSS 
stringSS 0
$UnblockPlayerDbUpdateFailureTemplateSS A
=SSB C
$strTT h
;TTh i
privateUU 
constUU 
stringUU .
"UnblockPlayerEntityFailureTemplateUU ?
=UU@ A
$strVV t
;VVt u
privateWW 
constWW 
stringWW +
UnblockPlayerSqlFailureTemplateWW <
=WW= >
$strXX l
;XXl m
privateZZ 
constZZ 
stringZZ 9
-UpdateFriendshipStatusDbUpdateFailureTemplateZZ J
=ZZK L
$str[[ q
+[[r s
$str\\ "
;\\" #
private]] 
const]] 
string]] 7
+UpdateFriendshipStatusEntityFailureTemplate]] H
=]]I J
$str^^ f
+^^g h
$str__ 9
;__9 :
private`` 
const`` 
string`` 4
(UpdateFriendshipStatusSqlFailureTemplate`` E
=``F G
$straa `
+aaa b
$strbb 9
;bb9 :
privatedd 
constdd 
stringdd ,
 DatabaseConnectionFailureMessagedd =
=dd> ?
$strdd@ d
;ddd e
privateee 
constee 
stringee )
SavePlayerBlockFailureMessageee :
=ee; <
$stree= k
;eek l
privateff 
constff 
stringff /
#ExecuteBlockOperationFailureMessageff @
=ffA B
$strffC w
;ffw x
privategg 
constgg 
stringgg -
!CreateFriendRequestFailureMessagegg >
=gg? @
$strggA s
;ggs t
privatehh 
consthh 
stringhh -
!InsertFriendRequestFailureMessagehh >
=hh? @
$strhhA s
;hhs t
privateii 
constii 
stringii *
DeleteFriendshipFailureMessageii ;
=ii< =
$strii> n
;iin o
privatejj 
constjj 
stringjj 3
'ExecuteFriendshipDeletionFailureMessagejj D
=jjE F
$strkk D
;kkD E
privatell 
constll 
stringll /
#QueryFriendshipRecordFailureMessagell @
=llA B
$strmm @
;mm@ A
privatenn 
constnn 
stringnn *
QueryFriendsListFailureMessagenn ;
=nn< =
$strnn> m
;nnm n
privateoo 
constoo 
stringoo .
"QueryPendingRequestsFailureMessageoo ?
=oo@ A
$strooB l
;ool m
privatepp 
constpp 
stringpp +
QuerySentRequestsFailureMessagepp <
=pp= >
$strpp? f
;ppf g
privateqq 
constqq 
stringqq 0
$QueryPlayerBlockStatusFailureMessageqq A
=qqB C
$strqqD j
;qqj k
privaterr 
constrr 
stringrr *
RemoveFriendshipFailureMessagerr ;
=rr< =
$strrr> n
;rrn o
privatess 
constss 
stringss 2
&ExecuteFriendshipRemovalFailureMessagess C
=ssD E
$strtt C
;ttC D
privateuu 
constuu 
stringuu +
RemovePlayerBlockFailureMessageuu <
=uu= >
$struu? q
;uuq r
privatevv 
constvv 
stringvv 1
%ExecuteUnblockOperationFailureMessagevv B
=vvC D
$strww B
;wwB C
privatexx 
constxx 
stringxx 0
$UpdateFriendshipStatusFailureMessagexx A
=xxB C
$stryy A
;yyA B
privatezz 
constzz 
stringzz -
!ExecuteStatusUpdateFailureMessagezz >
=zz? @
$strzzA s
;zzs t
private|| 
readonly|| 
ILoggerService|| '
_logger||( /
;||/ 0
public~~  
FriendshipRepository~~ #
(~~# $
ILoggerService~~$ 2
logger~~3 9
)~~9 :
{ 	
_logger
ÄÄ 
=
ÄÄ 
logger
ÄÄ 
??
ÄÄ 
throw
ÄÄ  %
new
ÄÄ& )#
ArgumentNullException
ÄÄ* ?
(
ÄÄ? @
nameof
ÄÄ@ F
(
ÄÄF G
logger
ÄÄG M
)
ÄÄM N
)
ÄÄN O
;
ÄÄO P
}
ÅÅ 	
public
ÉÉ 
void
ÉÉ 
BlockPlayer
ÉÉ 
(
ÉÉ  
int
ÉÉ  #
	blockerId
ÉÉ$ -
,
ÉÉ- .
int
ÉÉ/ 2
	blockedId
ÉÉ3 <
)
ÉÉ< =
{
ÑÑ 	
try
ÖÖ 
{
ÜÜ 
using
áá 
(
áá +
TrickTakingMissionsBDEntities
áá 4
context
áá5 <
=
áá= >
new
áá? B+
TrickTakingMissionsBDEntities
ááC `
(
áá` a
)
ááa b
)
ááb c
{
àà 
PlayerBlock
ââ 
existingBlock
ââ  -
=
ââ. /
context
ââ0 7
.
ââ7 8
PlayerBlock
ââ8 C
.
ââC D
Find
ââD H
(
ââH I
	blockerId
ââI R
,
ââR S
	blockedId
ââT ]
)
ââ] ^
;
ââ^ _
if
ää 
(
ää 
existingBlock
ää %
==
ää& (
null
ää) -
)
ää- .
{
ãã 
PlayerBlock
åå #
newBlock
åå$ ,
=
åå- .
new
åå/ 2
PlayerBlock
åå3 >
{
çç 
IdBlockerUser
éé )
=
éé* +
	blockerId
éé, 5
,
éé5 6
IdBlockedUser
èè )
=
èè* +
	blockedId
èè, 5
,
èè5 6
	CreatedAt
êê %
=
êê& '
DateTime
êê( 0
.
êê0 1
UtcNow
êê1 7
}
ëë 
;
ëë 
context
íí 
.
íí  
PlayerBlock
íí  +
.
íí+ ,
Add
íí, /
(
íí/ 0
newBlock
íí0 8
)
íí8 9
;
íí9 :
}
ìì /
!RemoveExistingFriendshipInContext
îî 5
(
îî5 6
context
îî6 =
,
îî= >
	blockerId
îî? H
,
îîH I
	blockedId
îîJ S
)
îîS T
;
îîT U
context
ïï 
.
ïï 
SaveChanges
ïï '
(
ïï' (
)
ïï( )
;
ïï) *
}
ññ 
}
óó 
catch
òò 
(
òò 
DbUpdateException
òò $
ex
òò% '
)
òò' (
{
ôô 
_logger
öö 
.
öö 
Error
öö 
(
öö 
ex
öö  
,
öö  !0
"BlockPlayerDbUpdateFailureTemplate
öö" D
,
ööD E
	blockedId
ööF O
,
ööO P
	blockerId
ööQ Z
)
ööZ [
;
öö[ \
throw
õõ 
new
õõ '
InvalidOperationException
õõ 3
(
õõ3 4+
SavePlayerBlockFailureMessage
õõ4 Q
,
õõQ R
ex
õõS U
)
õõU V
;
õõV W
}
úú 
catch
ùù 
(
ùù 
EntityException
ùù "
ex
ùù# %
)
ùù% &
{
ûû 
_logger
üü 
.
üü 
Error
üü 
(
üü 
ex
üü  
,
üü  !.
 BlockPlayerEntityFailureTemplate
üü" B
,
üüB C
	blockedId
üüD M
,
üüM N
	blockerId
üüO X
)
üüX Y
;
üüY Z
throw
†† 
new
†† '
InvalidOperationException
†† 3
(
††3 4.
 DatabaseConnectionFailureMessage
††4 T
,
††T U
ex
††V X
)
††X Y
;
††Y Z
}
°° 
catch
¢¢ 
(
¢¢ 
SqlException
¢¢ 
ex
¢¢  "
)
¢¢" #
{
££ 
_logger
§§ 
.
§§ 
Error
§§ 
(
§§ 
ex
§§  
,
§§  !+
BlockPlayerSqlFailureTemplate
§§" ?
,
§§? @
	blockedId
§§A J
,
§§J K
	blockerId
§§L U
)
§§U V
;
§§V W
throw
•• 
new
•• '
InvalidOperationException
•• 3
(
••3 41
#ExecuteBlockOperationFailureMessage
••4 W
,
••W X
ex
••Y [
)
••[ \
;
••\ ]
}
¶¶ 
}
ßß 	
public
©© 
async
©© 
Task
©© &
CreateFriendRequestAsync
©© 2
(
©©2 3
int
©©3 6
senderUserId
©©7 C
,
©©C D
int
©©E H
receiverUserId
©©I W
)
©©W X
{
™™ 	
int
´´ 
	idUserLow
´´ 
=
´´ 
Math
´´  
.
´´  !
Min
´´! $
(
´´$ %
senderUserId
´´% 1
,
´´1 2
receiverUserId
´´3 A
)
´´A B
;
´´B C
int
¨¨ 

idUserHigh
¨¨ 
=
¨¨ 
Math
¨¨ !
.
¨¨! "
Max
¨¨" %
(
¨¨% &
senderUserId
¨¨& 2
,
¨¨2 3
receiverUserId
¨¨4 B
)
¨¨B C
;
¨¨C D
bool
≠≠ 
isRequestedByLow
≠≠ !
=
≠≠" #
senderUserId
≠≠$ 0
==
≠≠1 3
	idUserLow
≠≠4 =
;
≠≠= >
try
ØØ 
{
∞∞ 
using
±± 
(
±± +
TrickTakingMissionsBDEntities
±± 4
context
±±5 <
=
±±= >
new
±±? B+
TrickTakingMissionsBDEntities
±±C `
(
±±` a
)
±±a b
)
±±b c
{
≤≤ 

Friendship
≥≥ 
newFriendship
≥≥ ,
=
≥≥- .
new
≥≥/ 2

Friendship
≥≥3 =
{
¥¥ 
	IdUserLow
µµ !
=
µµ" #
	idUserLow
µµ$ -
,
µµ- .

IdUserHigh
∂∂ "
=
∂∂# $

idUserHigh
∂∂% /
,
∂∂/ 0
RequestedByLow
∑∑ &
=
∑∑' (
isRequestedByLow
∑∑) 9
,
∑∑9 :
Status
∏∏ 
=
∏∏  %
PendingFriendshipStatus
∏∏! 8
,
∏∏8 9
RequestedAt
ππ #
=
ππ$ %
DateTime
ππ& .
.
ππ. /
UtcNow
ππ/ 5
,
ππ5 6
RespondedAt
∫∫ #
=
∫∫$ %
null
∫∫& *
}
ªª 
;
ªª 
context
ΩΩ 
.
ΩΩ 

Friendship
ΩΩ &
.
ΩΩ& '
Add
ΩΩ' *
(
ΩΩ* +
newFriendship
ΩΩ+ 8
)
ΩΩ8 9
;
ΩΩ9 :
await
ææ 
context
ææ !
.
ææ! "
SaveChangesAsync
ææ" 2
(
ææ2 3
)
ææ3 4
;
ææ4 5
}
øø 
}
¿¿ 
catch
¡¡ 
(
¡¡ 
DbUpdateException
¡¡ $
ex
¡¡% '
)
¡¡' (
{
¬¬ 
_logger
√√ 
.
√√ 
Error
√√ 
(
√√ 
ex
√√  
,
√√  !8
*CreateFriendRequestDbUpdateFailureTemplate
√√" L
,
√√L M
senderUserId
√√N Z
,
√√Z [
receiverUserId
√√\ j
)
√√j k
;
√√k l
throw
ƒƒ 
new
ƒƒ '
InvalidOperationException
ƒƒ 3
(
ƒƒ3 4/
!CreateFriendRequestFailureMessage
ƒƒ4 U
,
ƒƒU V
ex
ƒƒW Y
)
ƒƒY Z
;
ƒƒZ [
}
≈≈ 
catch
∆∆ 
(
∆∆ 
EntityException
∆∆ "
ex
∆∆# %
)
∆∆% &
{
«« 
_logger
»» 
.
»» 
Error
»» 
(
»» 
ex
»»  
,
»»  !6
(CreateFriendRequestEntityFailureTemplate
»»" J
,
»»J K
senderUserId
»»L X
,
»»X Y
receiverUserId
»»Z h
)
»»h i
;
»»i j
throw
…… 
new
…… '
InvalidOperationException
…… 3
(
……3 4.
 DatabaseConnectionFailureMessage
……4 T
,
……T U
ex
……V X
)
……X Y
;
……Y Z
}
   
catch
ÀÀ 
(
ÀÀ 
SqlException
ÀÀ 
ex
ÀÀ  "
)
ÀÀ" #
{
ÃÃ 
_logger
ÕÕ 
.
ÕÕ 
Error
ÕÕ 
(
ÕÕ 
ex
ÕÕ  
,
ÕÕ  !3
%CreateFriendRequestSqlFailureTemplate
ÕÕ" G
,
ÕÕG H
senderUserId
ÕÕI U
,
ÕÕU V
receiverUserId
ÕÕW e
)
ÕÕe f
;
ÕÕf g
throw
ŒŒ 
new
ŒŒ '
InvalidOperationException
ŒŒ 3
(
ŒŒ3 4/
!InsertFriendRequestFailureMessage
ŒŒ4 U
,
ŒŒU V
ex
ŒŒW Y
)
ŒŒY Z
;
ŒŒZ [
}
œœ 
}
–– 	
public
““ 
async
““ 
Task
““ #
DeleteFriendshipAsync
““ /
(
““/ 0
int
““0 3
firstUserId
““4 ?
,
““? @
int
““A D
secondUserId
““E Q
)
““Q R
{
”” 	
int
‘‘ 
	idUserLow
‘‘ 
=
‘‘ 
Math
‘‘  
.
‘‘  !
Min
‘‘! $
(
‘‘$ %
firstUserId
‘‘% 0
,
‘‘0 1
secondUserId
‘‘2 >
)
‘‘> ?
;
‘‘? @
int
’’ 

idUserHigh
’’ 
=
’’ 
Math
’’ !
.
’’! "
Max
’’" %
(
’’% &
firstUserId
’’& 1
,
’’1 2
secondUserId
’’3 ?
)
’’? @
;
’’@ A
try
÷÷ 
{
◊◊ 
using
ÿÿ 
(
ÿÿ +
TrickTakingMissionsBDEntities
ÿÿ 4
context
ÿÿ5 <
=
ÿÿ= >
new
ÿÿ? B+
TrickTakingMissionsBDEntities
ÿÿC `
(
ÿÿ` a
)
ÿÿa b
)
ÿÿb c
{
ŸŸ 

Friendship
⁄⁄ 
entity
⁄⁄ %
=
⁄⁄& '
await
⁄⁄( -
context
⁄⁄. 5
.
⁄⁄5 6

Friendship
⁄⁄6 @
.
⁄⁄@ A
	FindAsync
⁄⁄A J
(
⁄⁄J K
	idUserLow
⁄⁄K T
,
⁄⁄T U

idUserHigh
⁄⁄V `
)
⁄⁄` a
;
⁄⁄a b
if
€€ 
(
€€ 
entity
€€ 
!=
€€ !
null
€€" &
)
€€& '
{
‹‹ 
context
›› 
.
››  

Friendship
››  *
.
››* +
Remove
››+ 1
(
››1 2
entity
››2 8
)
››8 9
;
››9 :
await
ﬁﬁ 
context
ﬁﬁ %
.
ﬁﬁ% &
SaveChangesAsync
ﬁﬁ& 6
(
ﬁﬁ6 7
)
ﬁﬁ7 8
;
ﬁﬁ8 9
}
ﬂﬂ 
}
‡‡ 
}
·· 
catch
‚‚ 
(
‚‚ 
DbUpdateException
‚‚ $
ex
‚‚% '
)
‚‚' (
{
„„ 
_logger
‰‰ 
.
‰‰ 
Error
‰‰ 
(
‰‰ 
ex
‰‰  
,
‰‰  !5
'DeleteFriendshipDbUpdateFailureTemplate
‰‰" I
,
‰‰I J
firstUserId
‰‰K V
,
‰‰V W
secondUserId
‰‰X d
)
‰‰d e
;
‰‰e f
throw
ÂÂ 
new
ÂÂ '
InvalidOperationException
ÂÂ 3
(
ÂÂ3 4,
DeleteFriendshipFailureMessage
ÂÂ4 R
,
ÂÂR S
ex
ÂÂT V
)
ÂÂV W
;
ÂÂW X
}
ÊÊ 
catch
ÁÁ 
(
ÁÁ 
EntityException
ÁÁ "
ex
ÁÁ# %
)
ÁÁ% &
{
ËË 
_logger
ÈÈ 
.
ÈÈ 
Error
ÈÈ 
(
ÈÈ 
ex
ÈÈ  
,
ÈÈ  !3
%DeleteFriendshipEntityFailureTemplate
ÈÈ" G
,
ÈÈG H
firstUserId
ÈÈI T
,
ÈÈT U
secondUserId
ÈÈV b
)
ÈÈb c
;
ÈÈc d
throw
ÍÍ 
new
ÍÍ '
InvalidOperationException
ÍÍ 3
(
ÍÍ3 4.
 DatabaseConnectionFailureMessage
ÍÍ4 T
,
ÍÍT U
ex
ÍÍV X
)
ÍÍX Y
;
ÍÍY Z
}
ÎÎ 
catch
ÏÏ 
(
ÏÏ 
SqlException
ÏÏ 
ex
ÏÏ  "
)
ÏÏ" #
{
ÌÌ 
_logger
ÓÓ 
.
ÓÓ 
Error
ÓÓ 
(
ÓÓ 
ex
ÓÓ  
,
ÓÓ  !0
"DeleteFriendshipSqlFailureTemplate
ÓÓ" D
,
ÓÓD E
firstUserId
ÓÓF Q
,
ÓÓQ R
secondUserId
ÓÓS _
)
ÓÓ_ `
;
ÓÓ` a
throw
ÔÔ 
new
ÔÔ '
InvalidOperationException
ÔÔ 3
(
ÔÔ3 45
'ExecuteFriendshipDeletionFailureMessage
ÔÔ4 [
,
ÔÔ[ \
ex
ÔÔ] _
)
ÔÔ_ `
;
ÔÔ` a
}
 
}
ÒÒ 	
public
ÛÛ 
async
ÛÛ 
Task
ÛÛ 
<
ÛÛ "
FriendshipRecordData
ÛÛ .
>
ÛÛ. / 
GetFriendshipAsync
ÛÛ0 B
(
ÛÛB C
int
ÛÛC F
firstUserId
ÛÛG R
,
ÛÛR S
int
ÛÛT W
secondUserId
ÛÛX d
)
ÛÛd e
{
ÙÙ 	"
FriendshipRecordData
ıı  

recordData
ıı! +
=
ıı, -
null
ıı. 2
;
ıı2 3
int
ˆˆ 
	idUserLow
ˆˆ 
=
ˆˆ 
Math
ˆˆ  
.
ˆˆ  !
Min
ˆˆ! $
(
ˆˆ$ %
firstUserId
ˆˆ% 0
,
ˆˆ0 1
secondUserId
ˆˆ2 >
)
ˆˆ> ?
;
ˆˆ? @
int
˜˜ 

idUserHigh
˜˜ 
=
˜˜ 
Math
˜˜ !
.
˜˜! "
Max
˜˜" %
(
˜˜% &
firstUserId
˜˜& 1
,
˜˜1 2
secondUserId
˜˜3 ?
)
˜˜? @
;
˜˜@ A
try
¯¯ 
{
˘˘ 
using
˙˙ 
(
˙˙ +
TrickTakingMissionsBDEntities
˙˙ 4
context
˙˙5 <
=
˙˙= >
new
˙˙? B+
TrickTakingMissionsBDEntities
˙˙C `
(
˙˙` a
)
˙˙a b
)
˙˙b c
{
˚˚ 

Friendship
¸¸ 
entity
¸¸ %
=
¸¸& '
await
¸¸( -
context
¸¸. 5
.
¸¸5 6

Friendship
¸¸6 @
.
¸¸@ A
	FindAsync
¸¸A J
(
¸¸J K
	idUserLow
¸¸K T
,
¸¸T U

idUserHigh
¸¸V `
)
¸¸` a
;
¸¸a b
if
˝˝ 
(
˝˝ 
entity
˝˝ 
!=
˝˝ !
null
˝˝" &
)
˝˝& '
{
˛˛ 

recordData
ˇˇ "
=
ˇˇ# $'
MapToFriendshipRecordData
ˇˇ% >
(
ˇˇ> ?
entity
ˇˇ? E
)
ˇˇE F
;
ˇˇF G
}
ÄÄ 
}
ÅÅ 
}
ÇÇ 
catch
ÉÉ 
(
ÉÉ 
EntityException
ÉÉ "
ex
ÉÉ# %
)
ÉÉ% &
{
ÑÑ 
_logger
ÖÖ 
.
ÖÖ 
Error
ÖÖ 
(
ÖÖ 
ex
ÖÖ  
,
ÖÖ  !0
"GetFriendshipEntityFailureTemplate
ÖÖ" D
,
ÖÖD E
firstUserId
ÖÖF Q
,
ÖÖQ R
secondUserId
ÖÖS _
)
ÖÖ_ `
;
ÖÖ` a
throw
ÜÜ 
new
ÜÜ '
InvalidOperationException
ÜÜ 3
(
ÜÜ3 4.
 DatabaseConnectionFailureMessage
ÜÜ4 T
,
ÜÜT U
ex
ÜÜV X
)
ÜÜX Y
;
ÜÜY Z
}
áá 
catch
àà 
(
àà 
SqlException
àà 
ex
àà  "
)
àà" #
{
ââ 
_logger
ää 
.
ää 
Error
ää 
(
ää 
ex
ää  
,
ää  !-
GetFriendshipSqlFailureTemplate
ää" A
,
ääA B
firstUserId
ääC N
,
ääN O
secondUserId
ääP \
)
ää\ ]
;
ää] ^
throw
ãã 
new
ãã '
InvalidOperationException
ãã 3
(
ãã3 41
#QueryFriendshipRecordFailureMessage
ãã4 W
,
ããW X
ex
ããY [
)
ãã[ \
;
ãã\ ]
}
åå 
return
éé 

recordData
éé 
;
éé 
}
èè 	
public
ëë 
List
ëë 
<
ëë 
FriendSummaryData
ëë %
>
ëë% &$
GetFriendsListByUserId
ëë' =
(
ëë= >
int
ëë> A
userId
ëëB H
)
ëëH I
{
íí 	
List
ìì 
<
ìì 
FriendSummaryData
ìì "
>
ìì" #
friends
ìì$ +
=
ìì, -
new
ìì. 1
List
ìì2 6
<
ìì6 7
FriendSummaryData
ìì7 H
>
ììH I
(
ììI J
)
ììJ K
;
ììK L
try
ïï 
{
ññ 
using
óó 
(
óó +
TrickTakingMissionsBDEntities
óó 4
context
óó5 <
=
óó= >
new
óó? B+
TrickTakingMissionsBDEntities
óóC `
(
óó` a
)
óóa b
)
óób c
{
òò 

IQueryable
ôô 
<
ôô 

Friendship
ôô )
>
ôô) *
query
ôô+ 0
=
ôô1 2
from
öö 

friendship
öö '
in
öö( *
context
öö+ 2
.
öö2 3

Friendship
öö3 =
.
öö= >
Include
öö> E
(
ööE F
$str
ööF L
)
ööL M
.
ööM N
Include
ööN U
(
ööU V
$str
ööV ]
)
öö] ^
where
õõ 

friendship
õõ (
.
õõ( )
Status
õõ) /
==
õõ0 2&
AcceptedFriendshipStatus
õõ3 K
&&
úú 
(
úú  

friendship
úú  *
.
úú* +
	IdUserLow
úú+ 4
==
úú5 7
userId
úú8 >
||
úú? A

friendship
úúB L
.
úúL M

IdUserHigh
úúM W
==
úúX Z
userId
úú[ a
)
úúa b
select
ùù 

friendship
ùù )
;
ùù) *
List
üü 
<
üü 

Friendship
üü #
>
üü# $
entities
üü% -
=
üü. /
query
üü0 5
.
üü5 6
ToList
üü6 <
(
üü< =
)
üü= >
;
üü> ?
foreach
†† 
(
†† 

Friendship
†† '
entity
††( .
in
††/ 1
entities
††2 :
)
††: ;
{
°° 
friends
¢¢ 
.
¢¢  
Add
¢¢  #
(
¢¢# $ 
MapToFriendSummary
¢¢$ 6
(
¢¢6 7
entity
¢¢7 =
,
¢¢= >
userId
¢¢? E
)
¢¢E F
)
¢¢F G
;
¢¢G H
}
££ 
}
§§ 
}
•• 
catch
¶¶ 
(
¶¶ 
EntityException
¶¶ "
ex
¶¶# %
)
¶¶% &
{
ßß 
_logger
®® 
.
®® 
Error
®® 
(
®® 
ex
®®  
,
®®  !1
#GetFriendsListEntityFailureTemplate
®®" E
,
®®E F
userId
®®G M
)
®®M N
;
®®N O
throw
©© 
new
©© '
InvalidOperationException
©© 3
(
©©3 4.
 DatabaseConnectionFailureMessage
©©4 T
,
©©T U
ex
©©V X
)
©©X Y
;
©©Y Z
}
™™ 
catch
´´ 
(
´´ 
SqlException
´´ 
ex
´´  "
)
´´" #
{
¨¨ 
_logger
≠≠ 
.
≠≠ 
Error
≠≠ 
(
≠≠ 
ex
≠≠  
,
≠≠  !.
 GetFriendsListSqlFailureTemplate
≠≠" B
,
≠≠B C
userId
≠≠D J
)
≠≠J K
;
≠≠K L
throw
ÆÆ 
new
ÆÆ '
InvalidOperationException
ÆÆ 3
(
ÆÆ3 4,
QueryFriendsListFailureMessage
ÆÆ4 R
,
ÆÆR S
ex
ÆÆT V
)
ÆÆV W
;
ÆÆW X
}
ØØ 
return
±± 
friends
±± 
;
±± 
}
≤≤ 	
public
¥¥ 
async
¥¥ 
Task
¥¥ 
<
¥¥ 
List
¥¥ 
<
¥¥ 
FriendRequestData
¥¥ 0
>
¥¥0 1
>
¥¥1 23
%GetPendingFriendRequestsByUserIdAsync
¥¥3 X
(
¥¥X Y
int
¥¥Y \
userId
¥¥] c
)
¥¥c d
{
µµ 	
List
∂∂ 
<
∂∂ 
FriendRequestData
∂∂ "
>
∂∂" #
pendingRequests
∂∂$ 3
=
∂∂4 5
new
∂∂6 9
List
∂∂: >
<
∂∂> ?
FriendRequestData
∂∂? P
>
∂∂P Q
(
∂∂Q R
)
∂∂R S
;
∂∂S T
try
∑∑ 
{
∏∏ 
using
ππ 
(
ππ +
TrickTakingMissionsBDEntities
ππ 4
context
ππ5 <
=
ππ= >
new
ππ? B+
TrickTakingMissionsBDEntities
ππC `
(
ππ` a
)
ππa b
)
ππb c
{
∫∫ 

IQueryable
ªª 
<
ªª 

Friendship
ªª )
>
ªª) *
query
ªª+ 0
=
ªª1 2
from
ºº 

friendship
ºº '
in
ºº( *
context
ºº+ 2
.
ºº2 3

Friendship
ºº3 =
.
ºº= >
Include
ºº> E
(
ººE F
$str
ººF L
)
ººL M
.
ººM N
Include
ººN U
(
ººU V
$str
ººV ]
)
ºº] ^
where
ΩΩ 

friendship
ΩΩ (
.
ΩΩ( )
Status
ΩΩ) /
==
ΩΩ0 2%
PendingFriendshipStatus
ΩΩ3 J
&&
ææ 
(
ææ  
(
ææ  !

friendship
ææ! +
.
ææ+ ,
	IdUserLow
ææ, 5
==
ææ6 8
userId
ææ9 ?
&&
ææ@ B
!
ææC D

friendship
ææD N
.
ææN O
RequestedByLow
ææO ]
)
ææ] ^
||
øø  "
(
øø# $

friendship
øø$ .
.
øø. /

IdUserHigh
øø/ 9
==
øø: <
userId
øø= C
&&
øøD F

friendship
øøG Q
.
øøQ R
RequestedByLow
øøR `
)
øø` a
)
øøa b
select
¿¿ 

friendship
¿¿ )
;
¿¿) *
List
¬¬ 
<
¬¬ 

Friendship
¬¬ #
>
¬¬# $
entities
¬¬% -
=
¬¬. /
await
¬¬0 5
query
¬¬6 ;
.
¬¬; <
ToListAsync
¬¬< G
(
¬¬G H
)
¬¬H I
;
¬¬I J
foreach
√√ 
(
√√ 

Friendship
√√ '
entity
√√( .
in
√√/ 1
entities
√√2 :
)
√√: ;
{
ƒƒ 
pendingRequests
≈≈ '
.
≈≈' (
Add
≈≈( +
(
≈≈+ ,$
MapToFriendRequestData
≈≈, B
(
≈≈B C
entity
≈≈C I
)
≈≈I J
)
≈≈J K
;
≈≈K L
}
∆∆ 
}
«« 
}
»» 
catch
…… 
(
…… 
EntityException
…… "
ex
……# %
)
……% &
{
   
_logger
ÀÀ 
.
ÀÀ 
Error
ÀÀ 
(
ÀÀ 
ex
ÀÀ  
,
ÀÀ  !5
'GetPendingRequestsEntityFailureTemplate
ÀÀ" I
,
ÀÀI J
userId
ÀÀK Q
)
ÀÀQ R
;
ÀÀR S
throw
ÃÃ 
new
ÃÃ '
InvalidOperationException
ÃÃ 3
(
ÃÃ3 4.
 DatabaseConnectionFailureMessage
ÃÃ4 T
,
ÃÃT U
ex
ÃÃV X
)
ÃÃX Y
;
ÃÃY Z
}
ÕÕ 
catch
ŒŒ 
(
ŒŒ 
SqlException
ŒŒ 
ex
ŒŒ  "
)
ŒŒ" #
{
œœ 
_logger
–– 
.
–– 
Error
–– 
(
–– 
ex
––  
,
––  !2
$GetPendingRequestsSqlFailureTemplate
––" F
,
––F G
userId
––H N
)
––N O
;
––O P
throw
—— 
new
—— '
InvalidOperationException
—— 3
(
——3 40
"QueryPendingRequestsFailureMessage
——4 V
,
——V W
ex
——X Z
)
——Z [
;
——[ \
}
““ 
return
‘‘ 
pendingRequests
‘‘ "
;
‘‘" #
}
’’ 	
public
◊◊ 
async
◊◊ 
Task
◊◊ 
<
◊◊ 
List
◊◊ 
<
◊◊ 
FriendRequestData
◊◊ 0
>
◊◊0 1
>
◊◊1 20
"GetSentFriendRequestsByUserIdAsync
◊◊3 U
(
◊◊U V
int
◊◊V Y
userId
◊◊Z `
)
◊◊` a
{
ÿÿ 	
List
ŸŸ 
<
ŸŸ 
FriendRequestData
ŸŸ "
>
ŸŸ" #
sentRequests
ŸŸ$ 0
=
ŸŸ1 2
new
ŸŸ3 6
List
ŸŸ7 ;
<
ŸŸ; <
FriendRequestData
ŸŸ< M
>
ŸŸM N
(
ŸŸN O
)
ŸŸO P
;
ŸŸP Q
try
€€ 
{
‹‹ 
using
›› 
(
›› +
TrickTakingMissionsBDEntities
›› 4
context
››5 <
=
››= >
new
››? B+
TrickTakingMissionsBDEntities
››C `
(
››` a
)
››a b
)
››b c
{
ﬁﬁ 

IQueryable
ﬂﬂ 
<
ﬂﬂ 

Friendship
ﬂﬂ )
>
ﬂﬂ) *
query
ﬂﬂ+ 0
=
ﬂﬂ1 2
from
‡‡ 

friendship
‡‡ '
in
‡‡( *
context
‡‡+ 2
.
‡‡2 3

Friendship
‡‡3 =
.
‡‡= >
Include
‡‡> E
(
‡‡E F
$str
‡‡F L
)
‡‡L M
.
‡‡M N
Include
‡‡N U
(
‡‡U V
$str
‡‡V ]
)
‡‡] ^
where
·· 

friendship
·· (
.
··( )
Status
··) /
==
··0 2%
PendingFriendshipStatus
··3 J
&&
‚‚ 
(
‚‚  
(
‚‚  !

friendship
‚‚! +
.
‚‚+ ,
	IdUserLow
‚‚, 5
==
‚‚6 8
userId
‚‚9 ?
&&
‚‚@ B

friendship
‚‚C M
.
‚‚M N
RequestedByLow
‚‚N \
)
‚‚\ ]
||
„„  "
(
„„# $

friendship
„„$ .
.
„„. /

IdUserHigh
„„/ 9
==
„„: <
userId
„„= C
&&
„„D F
!
„„G H

friendship
„„H R
.
„„R S
RequestedByLow
„„S a
)
„„a b
)
„„b c
select
‰‰ 

friendship
‰‰ )
;
‰‰) *
List
ÊÊ 
<
ÊÊ 

Friendship
ÊÊ #
>
ÊÊ# $
entities
ÊÊ% -
=
ÊÊ. /
await
ÊÊ0 5
query
ÊÊ6 ;
.
ÊÊ; <
ToListAsync
ÊÊ< G
(
ÊÊG H
)
ÊÊH I
;
ÊÊI J
foreach
ÁÁ 
(
ÁÁ 

Friendship
ÁÁ '
entity
ÁÁ( .
in
ÁÁ/ 1
entities
ÁÁ2 :
)
ÁÁ: ;
{
ËË 
sentRequests
ÈÈ $
.
ÈÈ$ %
Add
ÈÈ% (
(
ÈÈ( )$
MapToFriendRequestData
ÈÈ) ?
(
ÈÈ? @
entity
ÈÈ@ F
)
ÈÈF G
)
ÈÈG H
;
ÈÈH I
}
ÍÍ 
}
ÎÎ 
}
ÏÏ 
catch
ÌÌ 
(
ÌÌ 
EntityException
ÌÌ "
ex
ÌÌ# %
)
ÌÌ% &
{
ÓÓ 
_logger
ÔÔ 
.
ÔÔ 
Error
ÔÔ 
(
ÔÔ 
ex
ÔÔ  
,
ÔÔ  !2
$GetSentRequestsEntityFailureTemplate
ÔÔ" F
,
ÔÔF G
userId
ÔÔH N
)
ÔÔN O
;
ÔÔO P
throw
 
new
 '
InvalidOperationException
 3
(
3 4.
 DatabaseConnectionFailureMessage
4 T
,
T U
ex
V X
)
X Y
;
Y Z
}
ÒÒ 
catch
ÚÚ 
(
ÚÚ 
SqlException
ÚÚ 
ex
ÚÚ  "
)
ÚÚ" #
{
ÛÛ 
_logger
ÙÙ 
.
ÙÙ 
Error
ÙÙ 
(
ÙÙ 
ex
ÙÙ  
,
ÙÙ  !/
!GetSentRequestsSqlFailureTemplate
ÙÙ" C
,
ÙÙC D
userId
ÙÙE K
)
ÙÙK L
;
ÙÙL M
throw
ıı 
new
ıı '
InvalidOperationException
ıı 3
(
ıı3 4-
QuerySentRequestsFailureMessage
ıı4 S
,
ııS T
ex
ııU W
)
ııW X
;
ııX Y
}
ˆˆ 
return
¯¯ 
sentRequests
¯¯ 
;
¯¯  
}
˘˘ 	
public
˚˚ 
bool
˚˚ &
IsPlayerBlockedByPlayerA
˚˚ ,
(
˚˚, -
int
˚˚- 0
	playerAId
˚˚1 :
,
˚˚: ;
int
˚˚< ?
	playerBId
˚˚@ I
)
˚˚I J
{
¸¸ 	
bool
˝˝ 
	isBlocked
˝˝ 
=
˝˝ 
false
˝˝ "
;
˝˝" #
try
ˇˇ 
{
ÄÄ 
using
ÅÅ 
(
ÅÅ +
TrickTakingMissionsBDEntities
ÅÅ 4
context
ÅÅ5 <
=
ÅÅ= >
new
ÅÅ? B+
TrickTakingMissionsBDEntities
ÅÅC `
(
ÅÅ` a
)
ÅÅa b
)
ÅÅb c
{
ÇÇ 

IQueryable
ÉÉ 
<
ÉÉ 
PlayerBlock
ÉÉ *
>
ÉÉ* +
query
ÉÉ, 1
=
ÉÉ2 3
from
ÑÑ 
block
ÑÑ "
in
ÑÑ# %
context
ÑÑ& -
.
ÑÑ- .
PlayerBlock
ÑÑ. 9
where
ÖÖ 
(
ÖÖ 
block
ÖÖ $
.
ÖÖ$ %
IdBlockerUser
ÖÖ% 2
==
ÖÖ3 5
	playerAId
ÖÖ6 ?
&&
ÖÖ@ B
block
ÖÖC H
.
ÖÖH I
IdBlockedUser
ÖÖI V
==
ÖÖW Y
	playerBId
ÖÖZ c
)
ÖÖc d
||
ÜÜ 
(
ÜÜ  
block
ÜÜ  %
.
ÜÜ% &
IdBlockerUser
ÜÜ& 3
==
ÜÜ4 6
	playerBId
ÜÜ7 @
&&
ÜÜA C
block
ÜÜD I
.
ÜÜI J
IdBlockedUser
ÜÜJ W
==
ÜÜX Z
	playerAId
ÜÜ[ d
)
ÜÜd e
select
áá 
block
áá $
;
áá$ %
PlayerBlock
ââ 

foundBlock
ââ  *
=
ââ+ ,
query
ââ- 2
.
ââ2 3
FirstOrDefault
ââ3 A
(
ââA B
)
ââB C
;
ââC D
	isBlocked
ää 
=
ää 

foundBlock
ää  *
!=
ää+ -
null
ää. 2
;
ää2 3
}
ãã 
}
åå 
catch
çç 
(
çç 
EntityException
çç "
ex
çç# %
)
çç% &
{
éé 
_logger
èè 
.
èè 
Error
èè 
(
èè 
ex
èè  
,
èè  !2
$IsPlayerBlockedEntityFailureTemplate
èè" F
,
èèF G
	playerAId
èèH Q
,
èèQ R
	playerBId
èèS \
)
èè\ ]
;
èè] ^
throw
êê 
new
êê '
InvalidOperationException
êê 3
(
êê3 4.
 DatabaseConnectionFailureMessage
êê4 T
,
êêT U
ex
êêV X
)
êêX Y
;
êêY Z
}
ëë 
catch
íí 
(
íí 
SqlException
íí 
ex
íí  "
)
íí" #
{
ìì 
_logger
îî 
.
îî 
Error
îî 
(
îî 
ex
îî  
,
îî  !/
!IsPlayerBlockedSqlFailureTemplate
îî" C
,
îîC D
	playerAId
îîE N
,
îîN O
	playerBId
îîP Y
)
îîY Z
;
îîZ [
throw
ïï 
new
ïï '
InvalidOperationException
ïï 3
(
ïï3 42
$QueryPlayerBlockStatusFailureMessage
ïï4 X
,
ïïX Y
ex
ïïZ \
)
ïï\ ]
;
ïï] ^
}
ññ 
return
òò 
	isBlocked
òò 
;
òò 
}
ôô 	
public
õõ 
void
õõ 
RemoveFriendship
õõ $
(
õõ$ %
int
õõ% (
firstUserId
õõ) 4
,
õõ4 5
int
õõ6 9
secondUserId
õõ: F
)
õõF G
{
úú 	
try
ùù 
{
ûû 
using
üü 
(
üü +
TrickTakingMissionsBDEntities
üü 4
context
üü5 <
=
üü= >
new
üü? B+
TrickTakingMissionsBDEntities
üüC `
(
üü` a
)
üüa b
)
üüb c
{
†† /
!RemoveExistingFriendshipInContext
°° 5
(
°°5 6
context
°°6 =
,
°°= >
firstUserId
°°? J
,
°°J K
secondUserId
°°L X
)
°°X Y
;
°°Y Z
context
¢¢ 
.
¢¢ 
SaveChanges
¢¢ '
(
¢¢' (
)
¢¢( )
;
¢¢) *
}
££ 
}
§§ 
catch
•• 
(
•• 
DbUpdateException
•• $
ex
••% '
)
••' (
{
¶¶ 
_logger
ßß 
.
ßß 
Error
ßß 
(
ßß 
ex
ßß  
,
ßß  !5
'RemoveFriendshipDbUpdateFailureTemplate
ßß" I
,
ßßI J
firstUserId
ßßK V
,
ßßV W
secondUserId
ßßX d
)
ßßd e
;
ßße f
throw
®® 
new
®® '
InvalidOperationException
®® 3
(
®®3 4,
RemoveFriendshipFailureMessage
®®4 R
,
®®R S
ex
®®T V
)
®®V W
;
®®W X
}
©© 
catch
™™ 
(
™™ 
EntityException
™™ "
ex
™™# %
)
™™% &
{
´´ 
_logger
¨¨ 
.
¨¨ 
Error
¨¨ 
(
¨¨ 
ex
¨¨  
,
¨¨  !3
%RemoveFriendshipEntityFailureTemplate
¨¨" G
,
¨¨G H
firstUserId
¨¨I T
,
¨¨T U
secondUserId
¨¨V b
)
¨¨b c
;
¨¨c d
throw
≠≠ 
new
≠≠ '
InvalidOperationException
≠≠ 3
(
≠≠3 4.
 DatabaseConnectionFailureMessage
≠≠4 T
,
≠≠T U
ex
≠≠V X
)
≠≠X Y
;
≠≠Y Z
}
ÆÆ 
catch
ØØ 
(
ØØ 
SqlException
ØØ 
ex
ØØ  "
)
ØØ" #
{
∞∞ 
_logger
±± 
.
±± 
Error
±± 
(
±± 
ex
±±  
,
±±  !0
"RemoveFriendshipSqlFailureTemplate
±±" D
,
±±D E
firstUserId
±±F Q
,
±±Q R
secondUserId
±±S _
)
±±_ `
;
±±` a
throw
≤≤ 
new
≤≤ '
InvalidOperationException
≤≤ 3
(
≤≤3 44
&ExecuteFriendshipRemovalFailureMessage
≤≤4 Z
,
≤≤Z [
ex
≤≤\ ^
)
≤≤^ _
;
≤≤_ `
}
≥≥ 
}
¥¥ 	
public
∂∂ 
void
∂∂ 
UnblockPlayer
∂∂ !
(
∂∂! "
int
∂∂" %
	blockerId
∂∂& /
,
∂∂/ 0
int
∂∂1 4
	blockedId
∂∂5 >
)
∂∂> ?
{
∑∑ 	
try
∏∏ 
{
ππ 
using
∫∫ 
(
∫∫ +
TrickTakingMissionsBDEntities
∫∫ 4
context
∫∫5 <
=
∫∫= >
new
∫∫? B+
TrickTakingMissionsBDEntities
∫∫C `
(
∫∫` a
)
∫∫a b
)
∫∫b c
{
ªª 
PlayerBlock
ºº 
existingBlock
ºº  -
=
ºº. /
context
ºº0 7
.
ºº7 8
PlayerBlock
ºº8 C
.
ººC D
Find
ººD H
(
ººH I
	blockerId
ººI R
,
ººR S
	blockedId
ººT ]
)
ºº] ^
;
ºº^ _
if
ΩΩ 
(
ΩΩ 
existingBlock
ΩΩ %
!=
ΩΩ& (
null
ΩΩ) -
)
ΩΩ- .
{
ææ 
context
øø 
.
øø  
PlayerBlock
øø  +
.
øø+ ,
Remove
øø, 2
(
øø2 3
existingBlock
øø3 @
)
øø@ A
;
øøA B
context
¿¿ 
.
¿¿  
SaveChanges
¿¿  +
(
¿¿+ ,
)
¿¿, -
;
¿¿- .
}
¡¡ 
}
¬¬ 
}
√√ 
catch
ƒƒ 
(
ƒƒ 
DbUpdateException
ƒƒ $
ex
ƒƒ% '
)
ƒƒ' (
{
≈≈ 
_logger
∆∆ 
.
∆∆ 
Error
∆∆ 
(
∆∆ 
ex
∆∆  
,
∆∆  !2
$UnblockPlayerDbUpdateFailureTemplate
∆∆" F
,
∆∆F G
	blockedId
∆∆H Q
,
∆∆Q R
	blockerId
∆∆S \
)
∆∆\ ]
;
∆∆] ^
throw
«« 
new
«« '
InvalidOperationException
«« 3
(
««3 4-
RemovePlayerBlockFailureMessage
««4 S
,
««S T
ex
««U W
)
««W X
;
««X Y
}
»» 
catch
…… 
(
…… 
EntityException
…… "
ex
……# %
)
……% &
{
   
_logger
ÀÀ 
.
ÀÀ 
Error
ÀÀ 
(
ÀÀ 
ex
ÀÀ  
,
ÀÀ  !0
"UnblockPlayerEntityFailureTemplate
ÀÀ" D
,
ÀÀD E
	blockedId
ÀÀF O
,
ÀÀO P
	blockerId
ÀÀQ Z
)
ÀÀZ [
;
ÀÀ[ \
throw
ÃÃ 
new
ÃÃ '
InvalidOperationException
ÃÃ 3
(
ÃÃ3 4.
 DatabaseConnectionFailureMessage
ÃÃ4 T
,
ÃÃT U
ex
ÃÃV X
)
ÃÃX Y
;
ÃÃY Z
}
ÕÕ 
catch
ŒŒ 
(
ŒŒ 
SqlException
ŒŒ 
ex
ŒŒ  "
)
ŒŒ" #
{
œœ 
_logger
–– 
.
–– 
Error
–– 
(
–– 
ex
––  
,
––  !-
UnblockPlayerSqlFailureTemplate
––" A
,
––A B
	blockedId
––C L
,
––L M
	blockerId
––N W
)
––W X
;
––X Y
throw
—— 
new
—— '
InvalidOperationException
—— 3
(
——3 43
%ExecuteUnblockOperationFailureMessage
——4 Y
,
——Y Z
ex
——[ ]
)
——] ^
;
——^ _
}
““ 
}
”” 	
public
’’ 
async
’’ 
Task
’’ )
UpdateFriendshipStatusAsync
’’ 5
(
’’5 6
int
’’6 9
firstUserId
’’: E
,
’’E F
int
’’G J
secondUserId
’’K W
,
’’W X
byte
’’Y ]
status
’’^ d
)
’’d e
{
÷÷ 	
int
◊◊ 
	idUserLow
◊◊ 
=
◊◊ 
Math
◊◊  
.
◊◊  !
Min
◊◊! $
(
◊◊$ %
firstUserId
◊◊% 0
,
◊◊0 1
secondUserId
◊◊2 >
)
◊◊> ?
;
◊◊? @
int
ÿÿ 

idUserHigh
ÿÿ 
=
ÿÿ 
Math
ÿÿ !
.
ÿÿ! "
Max
ÿÿ" %
(
ÿÿ% &
firstUserId
ÿÿ& 1
,
ÿÿ1 2
secondUserId
ÿÿ3 ?
)
ÿÿ? @
;
ÿÿ@ A
try
⁄⁄ 
{
€€ 
using
‹‹ 
(
‹‹ +
TrickTakingMissionsBDEntities
‹‹ 4
context
‹‹5 <
=
‹‹= >
new
‹‹? B+
TrickTakingMissionsBDEntities
‹‹C `
(
‹‹` a
)
‹‹a b
)
‹‹b c
{
›› 

Friendship
ﬁﬁ 
entity
ﬁﬁ %
=
ﬁﬁ& '
await
ﬁﬁ( -
context
ﬁﬁ. 5
.
ﬁﬁ5 6

Friendship
ﬁﬁ6 @
.
ﬁﬁ@ A
	FindAsync
ﬁﬁA J
(
ﬁﬁJ K
	idUserLow
ﬁﬁK T
,
ﬁﬁT U

idUserHigh
ﬁﬁV `
)
ﬁﬁ` a
;
ﬁﬁa b
if
ﬂﬂ 
(
ﬂﬂ 
entity
ﬂﬂ 
!=
ﬂﬂ !
null
ﬂﬂ" &
)
ﬂﬂ& '
{
‡‡ 
entity
·· 
.
·· 
Status
·· %
=
··& '
status
··( .
;
··. /
entity
‚‚ 
.
‚‚ 
RespondedAt
‚‚ *
=
‚‚+ ,
DateTime
‚‚- 5
.
‚‚5 6
UtcNow
‚‚6 <
;
‚‚< =
await
„„ 
context
„„ %
.
„„% &
SaveChangesAsync
„„& 6
(
„„6 7
)
„„7 8
;
„„8 9
}
‰‰ 
}
ÂÂ 
}
ÊÊ 
catch
ÁÁ 
(
ÁÁ 
DbUpdateException
ÁÁ $
ex
ÁÁ% '
)
ÁÁ' (
{
ËË 
_logger
ÈÈ 
.
ÈÈ 
Error
ÈÈ 
(
ÈÈ 
ex
ÈÈ  
,
ÈÈ  !;
-UpdateFriendshipStatusDbUpdateFailureTemplate
ÈÈ" O
,
ÈÈO P
status
ÈÈQ W
,
ÈÈW X
firstUserId
ÈÈY d
,
ÈÈd e
secondUserId
ÈÈf r
)
ÈÈr s
;
ÈÈs t
throw
ÍÍ 
new
ÍÍ '
InvalidOperationException
ÍÍ 3
(
ÍÍ3 42
$UpdateFriendshipStatusFailureMessage
ÍÍ4 X
,
ÍÍX Y
ex
ÍÍZ \
)
ÍÍ\ ]
;
ÍÍ] ^
}
ÎÎ 
catch
ÏÏ 
(
ÏÏ 
EntityException
ÏÏ "
ex
ÏÏ# %
)
ÏÏ% &
{
ÌÌ 
_logger
ÓÓ 
.
ÓÓ 
Error
ÓÓ 
(
ÓÓ 
ex
ÓÓ  
,
ÓÓ  !9
+UpdateFriendshipStatusEntityFailureTemplate
ÓÓ" M
,
ÓÓM N
status
ÓÓO U
,
ÓÓU V
firstUserId
ÓÓW b
,
ÓÓb c
secondUserId
ÓÓd p
)
ÓÓp q
;
ÓÓq r
throw
ÔÔ 
new
ÔÔ '
InvalidOperationException
ÔÔ 3
(
ÔÔ3 4.
 DatabaseConnectionFailureMessage
ÔÔ4 T
,
ÔÔT U
ex
ÔÔV X
)
ÔÔX Y
;
ÔÔY Z
}
 
catch
ÒÒ 
(
ÒÒ 
SqlException
ÒÒ 
ex
ÒÒ  "
)
ÒÒ" #
{
ÚÚ 
_logger
ÛÛ 
.
ÛÛ 
Error
ÛÛ 
(
ÛÛ 
ex
ÛÛ  
,
ÛÛ  !6
(UpdateFriendshipStatusSqlFailureTemplate
ÛÛ" J
,
ÛÛJ K
status
ÛÛL R
,
ÛÛR S
firstUserId
ÛÛT _
,
ÛÛ_ `
secondUserId
ÛÛa m
)
ÛÛm n
;
ÛÛn o
throw
ÙÙ 
new
ÙÙ '
InvalidOperationException
ÙÙ 3
(
ÙÙ3 4/
!ExecuteStatusUpdateFailureMessage
ÙÙ4 U
,
ÙÙU V
ex
ÙÙW Y
)
ÙÙY Z
;
ÙÙZ [
}
ıı 
}
ˆˆ 	
private
¯¯ 
static
¯¯ 
FriendSummaryData
¯¯ ( 
MapToFriendSummary
¯¯) ;
(
¯¯; <

Friendship
¯¯< F
entity
¯¯G M
,
¯¯M N
int
¯¯O R
currentUserId
¯¯S `
)
¯¯` a
{
˘˘ 	
User
˙˙ 

friendUser
˙˙ 
=
˙˙ 
entity
˙˙ $
.
˙˙$ %
	IdUserLow
˙˙% .
==
˙˙/ 1
currentUserId
˙˙2 ?
?
˚˚ 
entity
˚˚ 
.
˚˚ 
User1
˚˚ 
:
¸¸ 
entity
¸¸ 
.
¸¸ 
User
¸¸ 
;
¸¸ 
return
˛˛ 
new
˛˛ 
FriendSummaryData
˛˛ (
{
ˇˇ 
IdUser
ÄÄ 
=
ÄÄ 

friendUser
ÄÄ #
.
ÄÄ# $
IdUser
ÄÄ$ *
,
ÄÄ* +
Username
ÅÅ 
=
ÅÅ 

friendUser
ÅÅ %
.
ÅÅ% &
Username
ÅÅ& .
,
ÅÅ. /
IsOnline
ÇÇ 
=
ÇÇ 

friendUser
ÇÇ %
.
ÇÇ% &
Status
ÇÇ& ,
==
ÇÇ- /
OnlineUserStatus
ÇÇ0 @
}
ÉÉ 
;
ÉÉ 
}
ÑÑ 	
private
ÜÜ 
static
ÜÜ 
FriendRequestData
ÜÜ ($
MapToFriendRequestData
ÜÜ) ?
(
ÜÜ? @

Friendship
ÜÜ@ J
entity
ÜÜK Q
)
ÜÜQ R
{
áá 	
User
àà 

senderUser
àà 
=
àà 
entity
àà $
.
àà$ %
RequestedByLow
àà% 3
?
ââ 
entity
ââ 
.
ââ 
User
ââ 
:
ää 
entity
ää 
.
ää 
User1
ää 
;
ää 
User
ãã 
receiverUser
ãã 
=
ãã 
entity
ãã  &
.
ãã& '
RequestedByLow
ãã' 5
?
åå 
entity
åå 
.
åå 
User1
åå 
:
çç 
entity
çç 
.
çç 
User
çç 
;
çç 
return
èè 
new
èè 
FriendRequestData
èè (
{
êê 
SenderIdUser
ëë 
=
ëë 

senderUser
ëë )
.
ëë) *
IdUser
ëë* 0
,
ëë0 1
SenderUsername
íí 
=
íí  

senderUser
íí! +
.
íí+ ,
Username
íí, 4
,
íí4 5
ReceiverIdUser
ìì 
=
ìì  
receiverUser
ìì! -
.
ìì- .
IdUser
ìì. 4
,
ìì4 5
ReceiverUsername
îî  
=
îî! "
receiverUser
îî# /
.
îî/ 0
Username
îî0 8
,
îî8 9
Status
ïï 
=
ïï 
entity
ïï 
.
ïï  
Status
ïï  &
,
ïï& '
RequestDate
ññ 
=
ññ 
entity
ññ $
.
ññ$ %
RequestedAt
ññ% 0
}
óó 
;
óó 
}
òò 	
private
öö 
static
öö "
FriendshipRecordData
öö +'
MapToFriendshipRecordData
öö, E
(
ööE F

Friendship
ööF P
entity
ööQ W
)
ööW X
{
õõ 	
return
úú 
new
úú "
FriendshipRecordData
úú +
{
ùù 
	IdUserLow
ûû 
=
ûû 
entity
ûû "
.
ûû" #
	IdUserLow
ûû# ,
,
ûû, -

IdUserHigh
üü 
=
üü 
entity
üü #
.
üü# $

IdUserHigh
üü$ .
,
üü. /
Status
†† 
=
†† 
entity
†† 
.
††  
Status
††  &
,
††& '
IsRequestedByLow
°°  
=
°°! "
entity
°°# )
.
°°) *
RequestedByLow
°°* 8
,
°°8 9
RequestedAt
¢¢ 
=
¢¢ 
entity
¢¢ $
.
¢¢$ %
RequestedAt
¢¢% 0
,
¢¢0 1
RespondedAt
££ 
=
££ 
entity
££ $
.
££$ %
RespondedAt
££% 0
}
§§ 
;
§§ 
}
•• 	
private
ßß 
static
ßß 
void
ßß /
!RemoveExistingFriendshipInContext
ßß =
(
ßß= >+
TrickTakingMissionsBDEntities
ßß> [
context
ßß\ c
,
ßßc d
int
®® 
firstUserId
®® 
,
®® 
int
®®  
secondUserId
®®! -
)
®®- .
{
©© 	
int
™™ 
	idUserLow
™™ 
=
™™ 
Math
™™  
.
™™  !
Min
™™! $
(
™™$ %
firstUserId
™™% 0
,
™™0 1
secondUserId
™™2 >
)
™™> ?
;
™™? @
int
´´ 

idUserHigh
´´ 
=
´´ 
Math
´´ !
.
´´! "
Max
´´" %
(
´´% &
firstUserId
´´& 1
,
´´1 2
secondUserId
´´3 ?
)
´´? @
;
´´@ A

Friendship
¨¨  
existingFriendship
¨¨ )
=
¨¨* +
context
¨¨, 3
.
¨¨3 4

Friendship
¨¨4 >
.
¨¨> ?
Find
¨¨? C
(
¨¨C D
	idUserLow
¨¨D M
,
¨¨M N

idUserHigh
¨¨O Y
)
¨¨Y Z
;
¨¨Z [
if
ÆÆ 
(
ÆÆ  
existingFriendship
ÆÆ "
!=
ÆÆ# %
null
ÆÆ& *
)
ÆÆ* +
{
ØØ 
context
∞∞ 
.
∞∞ 

Friendship
∞∞ "
.
∞∞" #
Remove
∞∞# )
(
∞∞) * 
existingFriendship
∞∞* <
)
∞∞< =
;
∞∞= >
}
±± 
}
≤≤ 	
}
≥≥ 
}¥¥ Ã
mC:\Users\oscar\source\repos\TrickTakingMissions\Server\Persistence\Repository\ModerationDatabaseConnection.cs
	namespace 	
Persistence
 
. 

Repository  
{ 
internal 
static 
class (
ModerationDatabaseConnection 6
{		 
internal

 
static

 
SqlConnection

 %
Open

& *
(

* +
)

+ ,
{ 	
string &
moderationConnectionString -
;- .
using 
( )
TrickTakingMissionsBDEntities 0
databaseContext1 @
=A B
newC F)
TrickTakingMissionsBDEntitiesG d
(d e
)e f
)f g
{ &
moderationConnectionString *
=+ ,
databaseContext- <
.< =
Database= E
.E F

ConnectionF P
.P Q
ConnectionStringQ a
;a b
} 
SqlConnection  
moderationConnection .
=/ 0
new1 4
SqlConnection5 B
(B C&
moderationConnectionStringC ]
)] ^
;^ _
try 
{  
moderationConnection $
.$ %
Open% )
() *
)* +
;+ ,
} 
catch 
( 
SqlException 
)  
{  
moderationConnection $
.$ %
Dispose% ,
(, -
)- .
;. /
throw 
; 
} 
return  
moderationConnection '
;' (
} 	
} 
}   “8
nC:\Users\oscar\source\repos\TrickTakingMissions\Server\Persistence\Repository\BlockedAccountEmailRepository.cs
	namespace

 	
Persistence


 
.

 

Repository

  
{ 
public 

sealed 
class )
BlockedAccountEmailRepository 5
:6 7*
IBlockedAccountEmailRepository8 V
{ 
private 
const 
string &
PersistenceFailureTemplate 7
=8 9
$str: o
;o p
private 
const 
string ,
 VerifyBlockedEmailFailureMessage =
=> ?
$str@ p
;p q
private 
const 
string 4
(PermanentRestrictionRequiresEmailMessage E
=F G
$str G
;G H
private 
const 
string !
SelectBlockedEmailSql 2
=3 4
$str u
;u v
private 
const 
string !
InsertBlockedEmailSql 2
=3 4
$str f
+g h
$str ?
+@ A
$str o
;o p
private 
readonly 
ILoggerService '
_logger( /
;/ 0
public )
BlockedAccountEmailRepository ,
(, -
ILoggerService- ;
logger< B
)B C
{ 	
_logger 
= 
logger 
?? 
throw  %
new& )!
ArgumentNullException* ?
(? @
nameof@ F
(F G
loggerG M
)M N
)N O
;O P
}   	
public"" 
bool"" ,
 IsAccountEmailPermanentlyBlocked"" 4
(""4 5
string""5 ;
accountEmail""< H
)""H I
{## 	
bool$$ !
isAccountEmailBlocked$$ &
;$$& '
try%% 
{&& 
using'' 
('' 
SqlConnection'' $ 
moderationConnection''% 9
='': ;(
ModerationDatabaseConnection''< X
.''X Y
Open''Y ]
(''] ^
)''^ _
)''_ `
using(( 
((( 

SqlCommand(( !
blockedEmailQuery((" 3
=((4 5
new((6 9

SqlCommand((: D
(((D E!
SelectBlockedEmailSql((E Z
,((Z [ 
moderationConnection((\ p
)((p q
)((q r
{)) #
AddEmailDigestParameter** +
(**+ ,
blockedEmailQuery**, =
,**= >
accountEmail**? K
)**K L
;**L M!
isAccountEmailBlocked++ )
=++* +
(++, -
int++- 0
)++0 1
blockedEmailQuery++1 B
.++B C
ExecuteScalar++C P
(++P Q
)++Q R
>++S T
$num++U V
;++V W
},, 
}-- 
catch.. 
(.. 
SqlException.. 
ex..  "
).." #
{// 
_logger00 
.00 
Error00 
(00 
ex00  
,00  !&
PersistenceFailureTemplate00" <
,00< =
nameof00> D
(00D E,
 IsAccountEmailPermanentlyBlocked00E e
)00e f
)00f g
;00g h
throw11 
new11 %
InvalidOperationException11 3
(113 4,
 VerifyBlockedEmailFailureMessage114 T
,11T U
ex11V X
)11X Y
;11Y Z
}22 
return44 !
isAccountEmailBlocked44 (
;44( )
}55 	
internal77 
static77 
void77 
BlockAccountEmail77 .
(77. /
SqlTransaction77/ =!
moderationTransaction77> S
,77S T
int77U X
accountUserId77Y f
)77f g
{88 	
string99 
accountEmail99 
;99  
using:: 
(:: 

SqlCommand:: 
accountEmailQuery:: /
=::0 1
new::2 5

SqlCommand::6 @
(::@ A
$str;; J
,;;J K!
moderationTransaction<< %
.<<% &

Connection<<& 0
,<<0 1!
moderationTransaction<<2 G
)<<G H
)<<H I
{== 
accountEmailQuery>> !
.>>! "

Parameters>>" ,
.>>, -
Add>>- 0
(>>0 1
$str>>1 A
,>>A B
	SqlDbType>>C L
.>>L M
Int>>M P
)>>P Q
.>>Q R
Value>>R W
=>>X Y
accountUserId>>Z g
;>>g h
accountEmail?? 
=?? 
accountEmailQuery?? 0
.??0 1
ExecuteScalar??1 >
(??> ?
)??? @
as??A C
string??D J
;??J K
}@@ 
ifBB 
(BB 
stringBB 
.BB 
IsNullOrWhiteSpaceBB )
(BB) *
accountEmailBB* 6
)BB6 7
)BB7 8
{CC 
throwDD 
newDD %
InvalidOperationExceptionDD 3
(DD3 44
(PermanentRestrictionRequiresEmailMessageDD4 \
)DD\ ]
;DD] ^
}EE 
usingGG 
(GG 

SqlCommandGG 
blockedEmailInsertGG 0
=GG1 2
newGG3 6

SqlCommandGG7 A
(GGA B!
InsertBlockedEmailSqlGGB W
,GGW X!
moderationTransactionHH %
.HH% &

ConnectionHH& 0
,HH0 1!
moderationTransactionHH2 G
)HHG H
)HHH I
{II #
AddEmailDigestParameterJJ '
(JJ' (
blockedEmailInsertJJ( :
,JJ: ;
accountEmailJJ< H
)JJH I
;JJI J
blockedEmailInsertKK "
.KK" #
ExecuteNonQueryKK# 2
(KK2 3
)KK3 4
;KK4 5
}LL 
}MM 	
privateOO 
staticOO 
voidOO #
AddEmailDigestParameterOO 3
(OO3 4

SqlCommandOO4 >
emailCommandOO? K
,OOK L
stringOOM S
accountEmailOOT `
)OO` a
{PP 	
stringQQ "
normalizedAccountEmailQQ )
=QQ* +
accountEmailQQ, 8
.QQ8 9
TrimQQ9 =
(QQ= >
)QQ> ?
.QQ? @
ToUpperInvariantQQ@ P
(QQP Q
)QQQ R
;QQR S
usingRR 
(RR 
SHA256RR 
emailHasherRR %
=RR& '
SHA256RR( .
.RR. /
CreateRR/ 5
(RR5 6
)RR6 7
)RR7 8
{SS 
emailCommandTT 
.TT 

ParametersTT '
.TT' (
AddTT( +
(TT+ ,
$strTT, :
,TT: ;
	SqlDbTypeTT< E
.TTE F
BinaryTTF L
,TTL M
$numTTN P
)TTP Q
.TTQ R
ValueTTR W
=TTX Y
emailHasherUU 
.UU  
ComputeHashUU  +
(UU+ ,
EncodingUU, 4
.UU4 5
UnicodeUU5 <
.UU< =
GetBytesUU= E
(UUE F"
normalizedAccountEmailUUF \
)UU\ ]
)UU] ^
;UU^ _
}VV 
}WW 	
}XX 
}YY 