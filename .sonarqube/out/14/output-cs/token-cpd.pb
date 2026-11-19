◊n
oC:\Users\oscar\source\repos\TrickTakingMissions\Server\Infrastructure.Moderation\ChatModerationCatalogBackup.cs
	namespace 	
Infrastructure
 
. 

Moderation #
{ 
public 

sealed 
class '
ChatModerationCatalogBackup 3
:4 5(
IChatModerationCatalogBackup6 R
{ 
private 
readonly 
string  
_validatedBackupPath  4
;4 5
public '
ChatModerationCatalogBackup *
(* +
string+ 1
validatedBackupPath2 E
)E F
{ 	 
_validatedBackupPath  
=! "
validatedBackupPath# 6
;6 7
} 	
public %
ChatModerationPreparation (
LoadEditableCatalog) <
(< =
string= C
catalogDirectoryD T
)T U
{ 	,
 IProhibitedChatExpressionCatalog ,
catalog- 4
=5 6
new7 :+
ProhibitedChatExpressionCatalog; Z
(Z [
catalogDirectory[ k
)k l
;l m
return 
PrepareExpressions %
(% &
catalog& -
.- ..
"GetAllSupportedLanguageExpressions. P
(P Q
)Q R
)R S
;S T
} 	
public %
ChatModerationPreparation (
LoadValidatedBackup) <
(< =
)= >
{ 	 
ChatCatalogReadState    
catalogState  ! -
=  . /
new  0 3 
ChatCatalogReadState  4 H
(  H I
)  I J
;  J K
using!! 
(!! 
	XmlReader!! 
catalogReader!! *
=!!+ , 
ChatCatalogXmlReader!!- A
.!!A B

OpenReader!!B L
(!!L M 
_validatedBackupPath!!M a
,!!a b
true!!c g
)!!g h
)!!h i
{"" 

ReadBackup## 
(## 
catalogReader## (
,##( )
catalogState##* 6
)##6 7
;##7 8
}$$ 
IReadOnlyCollection&& 
<&&  $
ProhibitedChatExpression&&  8
>&&8 9%
prohibitedChatExpressions&&: S
=&&T U
catalogState&&V b
.&&b c
Expressions&&c n
;&&n o 
ChatCatalogXmlReader''  
.''  !
ValidateCategories''! 3
(''3 4%
prohibitedChatExpressions''4 M
)''M N
;''N O
return(( 
PrepareExpressions(( %
(((% &%
prohibitedChatExpressions((& ?
)((? @
;((@ A
})) 	
public++ 
void++ 
SaveValidatedBackup++ '
(++' (%
ChatModerationPreparation++( A!
moderationPreparation++B W
)++W X
{,, 	
if-- 
(-- 
!-- !
moderationPreparation-- &
.--& '"
IsChatSendingAvailable--' =
)--= >
{.. 
throw// 
new// 
ArgumentException// +
(//+ ,
$str//, n
)//n o
;//o p
}00 
	Directory22 
.22 
CreateDirectory22 %
(22% &
Path22& *
.22* +
GetDirectoryName22+ ;
(22; < 
_validatedBackupPath22< P
)22P Q
)22Q R
;22R S
string33 
pendingBackupPath33 $
=33% & 
_validatedBackupPath33' ;
+33< =
$str33> A
+33B C
Guid33D H
.33H I
NewGuid33I P
(33P Q
)33Q R
.33R S
ToString33S [
(33[ \
$str33\ _
)33_ `
+33a b
$str33c i
;33i j
WriteBackup44 
(44 
pendingBackupPath44 )
,44) *!
moderationPreparation44+ @
.44@ A
Expressions44A L
)44L M
;44M N
if66 
(66 
File66 
.66 
Exists66 
(66  
_validatedBackupPath66 0
)660 1
)661 2
{77 
File88 
.88 
Replace88 
(88 
pendingBackupPath88 .
,88. / 
_validatedBackupPath880 D
,88D E
null88F J
)88J K
;88K L
}99 
else:: 
{;; 
File<< 
.<< 
Move<< 
(<< 
pendingBackupPath<< +
,<<+ , 
_validatedBackupPath<<- A
)<<A B
;<<B C
}== 
}>> 	
private@@ 
static@@ %
ChatModerationPreparation@@ 0
PrepareExpressions@@1 C
(@@C D
IReadOnlyCollectionAA 
<AA  $
ProhibitedChatExpressionAA  8
>AA8 9%
prohibitedChatExpressionsAA: S
)AAS T
{BB 	
returnCC 
newCC %
ChatModerationPreparationCC 0
{DD 
ExpressionsEE 
=EE %
prohibitedChatExpressionsEE 7
,EE7 8
MessageModeratorFF  
=FF! "
newFF# & 
ChatMessageModeratorFF' ;
(FF; <%
prohibitedChatExpressionsFF< U
)FFU V
}GG 
;GG 
}HH 	
privateJJ 
staticJJ 
voidJJ 

ReadBackupJJ &
(JJ& '
	XmlReaderJJ' 0
catalogReaderJJ1 >
,JJ> ? 
ChatCatalogReadStateJJ@ T
catalogStateJJU a
)JJa b
{KK 	
catalogReaderLL 
.LL 
MoveToContentLL '
(LL' (
)LL( )
;LL) *
ifMM 
(MM 
catalogReaderMM 
.MM 
NameMM "
!=MM# %
$strMM& 5
||MM6 8
catalogReaderMM9 F
.MMF G
GetAttributeMMG S
(MMS T
$strMMT ]
)MM] ^
!=MM_ a
$strMMb e
)MMe f
{NN 
throwOO 
newOO  
InvalidDataExceptionOO .
(OO. /
$strOO/ `
)OO` a
;OOa b
}PP 
HashSetRR 
<RR 
stringRR 
>RR 
loadedCulturesRR *
=RR+ ,
newRR- 0
HashSetRR1 8
<RR8 9
stringRR9 ?
>RR? @
(RR@ A
)RRA B
;RRB C
whileSS 
(SS 
catalogReaderSS  
.SS  !
ReadSS! %
(SS% &
)SS& '
)SS' (
{TT 
ifUU 
(UU 
catalogReaderUU !
.UU! "
NodeTypeUU" *
==UU+ -
XmlNodeTypeUU. 9
.UU9 :
ElementUU: A
)UUA B
{VV 
ReadBackupCultureWW %
(WW% &
catalogReaderWW& 3
,WW3 4
catalogStateWW5 A
,WWA B
loadedCulturesWWC Q
)WWQ R
;WWR S
}XX 
elseYY 
ifYY 
(YY 
catalogReaderYY &
.YY& '
NodeTypeYY' /
!=YY0 2
XmlNodeTypeYY3 >
.YY> ?

EndElementYY? I
&&YYJ L
catalogReaderZZ !
.ZZ! "
NodeTypeZZ" *
!=ZZ+ -
XmlNodeTypeZZ. 9
.ZZ9 :

WhitespaceZZ: D
)ZZD E
{[[ 
throw\\ 
new\\  
InvalidDataException\\ 2
(\\2 3
$str\\3 W
)\\W X
;\\X Y
}]] 
}^^ 
if`` 
(`` 
loadedCultures`` 
.`` 
Count`` $
!=``% '
$num``( )
)``) *
{aa 
throwbb 
newbb  
InvalidDataExceptionbb .
(bb. /
$strbb/ k
)bbk l
;bbl m
}cc 
}dd 	
privateff 
staticff 
voidff 
ReadBackupCultureff -
(ff- .
	XmlReaderff. 7
catalogReaderff8 E
,ffE F 
ChatCatalogReadStateffG [
catalogStateff\ h
,ffh i
HashSetgg 
<gg 
stringgg 
>gg 
loadedCulturesgg *
)gg* +
{hh 	
stringii 
cultureNameii 
=ii  
catalogReaderii! .
.ii. /
GetAttributeii/ ;
(ii; <
$strii< E
)iiE F
;iiF G
ifjj 
(jj 
catalogReaderjj 
.jj 
Depthjj #
!=jj$ &
$numjj' (
||jj) +
(jj, -
cultureNamejj- 8
!=jj9 ;
$strjj< C
&&jjD F
cultureNamejjG R
!=jjS U
$strjjV ]
)jj] ^
||jj_ a
!kk 
loadedCultureskk 
.kk  
Addkk  #
(kk# $
cultureNamekk$ /
)kk/ 0
)kk0 1
{ll 
throwmm 
newmm  
InvalidDataExceptionmm .
(mm. /
$strmm/ n
)mmn o
;mmo p
}nn 
usingpp 
(pp 
	XmlReaderpp 
cultureReaderpp *
=pp+ ,
catalogReaderpp- :
.pp: ;
ReadSubtreepp; F
(ppF G
)ppG H
)ppH I
{qq  
ChatCatalogXmlReaderrr $
.rr$ %
ReadCatalogrr% 0
(rr0 1
cultureReaderrr1 >
,rr> ?
cultureNamerr@ K
,rrK L
catalogStaterrM Y
)rrY Z
;rrZ [
}ss 
}tt 	
privatevv 
staticvv 
voidvv 
WriteBackupvv '
(vv' (
stringvv( .

backupPathvv/ 9
,vv9 :
IReadOnlyCollectionww 
<ww  $
ProhibitedChatExpressionww  8
>ww8 9%
prohibitedChatExpressionsww: S
)wwS T
{xx 	
XmlWriterSettingsyy  
backupWriterSettingsyy 2
=yy3 4
newyy5 8
XmlWriterSettingsyy9 J
{zz 
Encoding{{ 
={{ 
new{{ 
UTF8Encoding{{ +
({{+ ,
false{{, 1
){{1 2
,{{2 3
Indent|| 
=|| 
true|| 
,|| 
NewLineChars}} 
=}} 
$str}} %
}~~ 
;~~ 
using 
( 
	XmlWriter 
catalogWriter *
=+ ,
	XmlWriter- 6
.6 7
Create7 =
(= >

backupPath> H
,H I 
backupWriterSettingsJ ^
)^ _
)_ `
{
ÄÄ 
catalogWriter
ÅÅ 
.
ÅÅ 
WriteStartElement
ÅÅ /
(
ÅÅ/ 0
$str
ÅÅ0 ?
)
ÅÅ? @
;
ÅÅ@ A
catalogWriter
ÇÇ 
.
ÇÇ "
WriteAttributeString
ÇÇ 2
(
ÇÇ2 3
$str
ÇÇ3 <
,
ÇÇ< =
$str
ÇÇ> A
)
ÇÇA B
;
ÇÇB C
foreach
ÉÉ 
(
ÉÉ 
string
ÉÉ 
cultureName
ÉÉ  +
in
ÉÉ, .
new
ÉÉ/ 2
[
ÉÉ2 3
]
ÉÉ3 4
{
ÉÉ5 6
$str
ÉÉ7 >
,
ÉÉ> ?
$str
ÉÉ@ G
}
ÉÉH I
)
ÉÉI J
{
ÑÑ 
WriteCulture
ÖÖ  
(
ÖÖ  !
catalogWriter
ÖÖ! .
,
ÖÖ. /
cultureName
ÖÖ0 ;
,
ÖÖ; <'
prohibitedChatExpressions
ÖÖ= V
)
ÖÖV W
;
ÖÖW X
}
ÜÜ 
catalogWriter
àà 
.
àà 
WriteEndElement
àà -
(
àà- .
)
àà. /
;
àà/ 0
}
ââ 
}
ää 	
private
åå 
static
åå 
void
åå 
WriteCulture
åå (
(
åå( )
	XmlWriter
åå) 2
catalogWriter
åå3 @
,
åå@ A
string
ååB H
cultureName
ååI T
,
ååT U!
IReadOnlyCollection
çç 
<
çç  &
ProhibitedChatExpression
çç  8
>
çç8 9'
prohibitedChatExpressions
çç: S
)
ççS T
{
éé 	
catalogWriter
èè 
.
èè 
WriteStartElement
èè +
(
èè+ ,
$str
èè, 5
)
èè5 6
;
èè6 7
catalogWriter
êê 
.
êê "
WriteAttributeString
êê .
(
êê. /
$str
êê/ 8
,
êê8 9
cultureName
êê: E
)
êêE F
;
êêF G
foreach
ëë 
(
ëë &
ProhibitedChatExpression
ëë -

expression
ëë. 8
in
ëë9 ;'
prohibitedChatExpressions
íí )
.
íí) *
Where
íí* /
(
íí/ 0

expression
íí0 :
=>
íí; =

expression
íí> H
.
ííH I#
ExpressionCultureName
ííI ^
==
íí_ a
cultureName
ííb m
)
íím n
)
íín o
{
ìì 
catalogWriter
îî 
.
îî 
WriteStartElement
îî /
(
îî/ 0
$str
îî0 <
)
îî< =
;
îî= >
catalogWriter
ïï 
.
ïï "
WriteAttributeString
ïï 2
(
ïï2 3
$str
ïï3 =
,
ïï= >

expression
ïï? I
.
ïïI J 
InfractionCategory
ïïJ \
.
ïï\ ]
ToString
ïï] e
(
ïïe f
)
ïïf g
)
ïïg h
;
ïïh i
catalogWriter
ññ 
.
ññ "
WriteAttributeString
ññ 2
(
ññ2 3
$str
ññ3 E
,
ññE F

XmlConvert
óó 
.
óó 
ToString
óó '
(
óó' (

expression
óó( 2
.
óó2 3'
CanMatchObfuscatedLetters
óó3 L
)
óóL M
)
óóM N
;
óóN O
catalogWriter
òò 
.
òò 
WriteString
òò )
(
òò) *

expression
òò* 4
.
òò4 5
ExpressionText
òò5 C
)
òòC D
;
òòD E
catalogWriter
ôô 
.
ôô 
WriteEndElement
ôô -
(
ôô- .
)
ôô. /
;
ôô/ 0
}
öö 
catalogWriter
úú 
.
úú 
WriteEndElement
úú )
(
úú) *
)
úú* +
;
úú+ ,
}
ùù 	
}
ûû 
}üü √
sC:\Users\oscar\source\repos\TrickTakingMissions\Server\Infrastructure.Moderation\ProhibitedChatExpressionCatalog.cs
	namespace 	
Infrastructure
 
. 

Moderation #
{		 
public 

sealed 
class +
ProhibitedChatExpressionCatalog 7
:8 9,
 IProhibitedChatExpressionCatalog: Z
{ 
private 
readonly 
IReadOnlyCollection ,
<, -$
ProhibitedChatExpression- E
>E F&
_prohibitedChatExpressionsG a
;a b
public +
ProhibitedChatExpressionCatalog .
(. /
string/ 5&
moderationCatalogDirectory6 P
)P Q
{ 	 
ChatCatalogReadState  
catalogState! -
=. /
new0 3 
ChatCatalogReadState4 H
(H I
)I J
;J K
LoadCulture 
( &
moderationCatalogDirectory 2
,2 3
$str4 ;
,; <
catalogState= I
)I J
;J K
LoadCulture 
( &
moderationCatalogDirectory 2
,2 3
$str4 ;
,; <
catalogState= I
)I J
;J K&
_prohibitedChatExpressions &
=' (
catalogState) 5
.5 6
Expressions6 A
;A B 
ChatCatalogXmlReader  
.  !
ValidateCategories! 3
(3 4&
_prohibitedChatExpressions4 N
)N O
;O P
} 	
public 
IReadOnlyCollection "
<" #$
ProhibitedChatExpression# ;
>; <.
"GetAllSupportedLanguageExpressions= _
(_ `
)` a
{ 	
return &
_prohibitedChatExpressions -
;- .
} 	
private 
static 
void 
LoadCulture '
(' (
string( .
	directory/ 8
,8 9
string: @
cultureNameA L
,L M 
ChatCatalogReadStateN b
catalogStatec o
)o p
{   	
string!! 
catalogPath!! 
=!!  
Path!!! %
.!!% &
Combine!!& -
(!!- .
	directory!!. 7
,!!7 8
$str!!9 U
+!!V W
cultureName!!X c
+!!d e
$str!!f l
)!!l m
;!!m n
using"" 
("" 
	XmlReader"" 
catalogReader"" *
=""+ , 
ChatCatalogXmlReader""- A
.""A B

OpenReader""B L
(""L M
catalogPath""M X
,""X Y
false""Z _
)""_ `
)""` a
{##  
ChatCatalogXmlReader$$ $
.$$$ %
ReadCatalog$$% 0
($$0 1
catalogReader$$1 >
,$$> ?
cultureName$$@ K
,$$K L
catalogState$$M Y
)$$Y Z
;$$Z [
while%% 
(%% 
catalogReader%% $
.%%$ %
Read%%% )
(%%) *
)%%* +
)%%+ ,
{&& 
}(( 
})) 
}** 	
}++ 
},, ∑ä
hC:\Users\oscar\source\repos\TrickTakingMissions\Server\Infrastructure.Moderation\ChatCatalogXmlReader.cs
	namespace

 	
Infrastructure


 
.

 

Moderation

 #
{ 
internal 
static 
class  
ChatCatalogXmlReader .
{ 
private 
const 
long $
MaximumCatalogCharacters 3
=4 5
$num6 <
;< =
private 
const 
long #
MaximumCatalogFileBytes 2
=3 4
$num5 <
;< =
internal 
static 
	XmlReader !

OpenReader" ,
(, -
string- 3
catalogPath4 ?
,? @
boolA E
isCombinedBackupF V
)V W
{ 	
long 
maximumCharacters "
=# $$
MaximumCatalogCharacters% =
;= >
if 
( 
isCombinedBackup  
)  !
{ 
maximumCharacters !
*=" $
$num% &
;& '
} 
long 
maximumFileBytes !
=" #
isCombinedBackup$ 4
?5 6#
MaximumCatalogFileBytes7 N
*O P
$numQ R
:S T#
MaximumCatalogFileBytesU l
;l m

FileStream 
catalogStream $
=% &
new' *

FileStream+ 5
(5 6
catalogPath6 A
,A B
FileModeC K
.K L
OpenL P
,P Q

FileAccessR \
.\ ]
Read] a
,a b
	FileSharec l
.l m
Readm q
)q r
;r s
	XmlReader 
catalogReader #
=$ %
null& *
;* +
try 
{ 
if 
( 
catalogStream !
.! "
Length" (
>) *
maximumFileBytes+ ;
); <
{   
throw!! 
new!!  
InvalidDataException!! 2
(!!2 3
$str!!3 c
)!!c d
;!!d e
}"" 
catalogReader$$ 
=$$ 
	XmlReader$$  )
.$$) *
Create$$* 0
($$0 1
catalogStream$$1 >
,$$> ?
new$$@ C
XmlReaderSettings$$D U
{%% 
DtdProcessing&& !
=&&" #
DtdProcessing&&$ 1
.&&1 2
Prohibit&&2 :
,&&: ;
XmlResolver'' 
=''  !
null''" &
,''& '#
MaxCharactersInDocument(( +
=((, -
maximumCharacters((. ?
,((? @
IgnoreComments)) "
=))# $
true))% )
,))) *
IgnoreWhitespace** $
=**% &
true**' +
,**+ ,

CloseInput++ 
=++  
true++! %
},, 
,,, 
catalogPath,, 
),, 
;,,  
}-- 
finally.. 
{// 
if00 
(00 
catalogReader00 !
==00" $
null00% )
)00) *
{11 
catalogStream22 !
.22! "
Dispose22" )
(22) *
)22* +
;22+ ,
}33 
}44 
return66 
catalogReader66  
;66  !
}77 	
internal99 
static99 
void99 
ReadCatalog99 (
(99( )
	XmlReader99) 2
catalogReader993 @
,99@ A
string99B H
expectedCulture99I X
,99X Y 
ChatCatalogReadState::  
catalogState::! -
)::- .
{;; 	
catalogReader<< 
.<< 
MoveToContent<< '
(<<' (
)<<( )
;<<) *
if== 
(== 
catalogReader== 
.== 
Name== "
!===# %
$str==& /
||==0 2
catalogReader==3 @
.==@ A
GetAttribute==A M
(==M N
$str==N W
)==W X
!===Y [
expectedCulture==\ k
)==k l
{>> 
throw?? 
CatalogError?? "
(??" #
catalogReader??# 0
,??0 1
$str??2 [
)??[ \
;??\ ]
}@@ 
intBB 
catalogDepthBB 
=BB 
catalogReaderBB ,
.BB, -
DepthBB- 2
;BB2 3
whileCC 
(CC 
catalogReaderCC  
.CC  !
ReadCC! %
(CC% &
)CC& '
&&CC( *
catalogReaderCC+ 8
.CC8 9
DepthCC9 >
>CC? @
catalogDepthCCA M
)CCM N
{DD 
ReadCatalogNodeEE 
(EE  
catalogReaderEE  -
,EE- .
expectedCultureEE/ >
,EE> ?
catalogStateEE@ L
)EEL M
;EEM N
}FF 
}GG 	
internalII 
staticII 
voidII 
ValidateCategoriesII /
(II/ 0
IReadOnlyCollectionII0 C
<IIC D$
ProhibitedChatExpressionIID \
>II\ ]
expressionsII^ i
)IIi j
{JJ 	
foreachKK 
(KK 
stringKK 
cultureNameKK '
inKK( *
newKK+ .
[KK. /
]KK/ 0
{KK1 2
$strKK3 :
,KK: ;
$strKK< C
}KKD E
)KKE F
{LL 
boolMM 
hasProfanityMM !
=MM" #
expressionsMM$ /
.MM/ 0
AnyMM0 3
(MM3 4

expressionMM4 >
=>MM? A

expressionMMB L
.MML M!
ExpressionCultureNameMMM b
==MMc e
cultureNameMMf q
&&MMr t

expressionNN 
.NN 
InfractionCategoryNN 1
==NN2 4"
ChatInfractionCategoryNN5 K
.NNK L
	ProfanityNNL U
)NNU V
;NNV W
boolOO 

hasThreatsOO 
=OO  !
expressionsOO" -
.OO- .
AnyOO. 1
(OO1 2

expressionOO2 <
=>OO= ?

expressionOO@ J
.OOJ K!
ExpressionCultureNameOOK `
==OOa c
cultureNameOOd o
&&OOp r

expressionPP 
.PP 
InfractionCategoryPP 1
==PP2 4"
ChatInfractionCategoryPP5 K
.PPK L
ThreatPPL R
)PPR S
;PPS T
ifQQ 
(QQ 
!QQ 
hasProfanityQQ !
||QQ" $
!QQ% &

hasThreatsQQ& 0
)QQ0 1
{RR 
throwSS 
newSS  
InvalidDataExceptionSS 2
(SS2 3
$strSS3 t
)SSt u
;SSu v
}TT 
}UU 
}VV 	
privateXX 
staticXX 
voidXX 
ReadCatalogNodeXX +
(XX+ ,
	XmlReaderXX, 5
catalogReaderXX6 C
,XXC D
stringXXE K
cultureNameXXL W
,XXW X 
ChatCatalogReadStateYY  
catalogStateYY! -
)YY- .
{ZZ 	
if[[ 
([[ 
catalogReader[[ 
.[[ 
NodeType[[ &
==[[' )
XmlNodeType[[* 5
.[[5 6
Element[[6 =
)[[= >
{\\ 
if]] 
(]] 
catalogReader]] !
.]]! "
Name]]" &
!=]]' )
$str]]* 6
)]]6 7
{^^ 
throw__ 
CatalogError__ &
(__& '
catalogReader__' 4
,__4 5
$str__6 n
)__n o
;__o p
}`` 
catalogStatebb 
.bb 
AddExpressionbb *
(bb* +
ReadExpressionbb+ 9
(bb9 :
catalogReaderbb: G
,bbG H
cultureNamebbI T
)bbT U
)bbU V
;bbV W
}cc 
elsedd 
ifdd 
(dd 
catalogReaderdd "
.dd" #
NodeTypedd# +
!=dd, .
XmlNodeTypedd/ :
.dd: ;

EndElementdd; E
&&ddF H
catalogReaderee 
.ee 
NodeTypeee &
!=ee' )
XmlNodeTypeee* 5
.ee5 6

Whitespaceee6 @
)ee@ A
{ff 
throwgg 
CatalogErrorgg "
(gg" #
catalogReadergg# 0
,gg0 1
$strgg2 _
)gg_ `
;gg` a
}hh 
}ii 	
privatekk 
statickk $
ProhibitedChatExpressionkk /
ReadExpressionkk0 >
(kk> ?
	XmlReaderkk? H
catalogReaderkkI V
,kkV W
stringkkX ^
cultureNamekk_ j
)kkj k
{ll 	"
ChatInfractionCategorymm "
infractionCategorymm# 5
=mm6 7
ReadCategorymm8 D
(mmD E
catalogReadermmE R
)mmR S
;mmS T
boolnn 
canMatchObfuscationnn $
=nn% &

XmlConvertnn' 1
.nn1 2
	ToBooleannn2 ;
(nn; <
catalogReadernn< I
.nnI J
GetAttributennJ V
(nnV W
$strnnW i
)nni j
??nnk m
$strnnn u
)nnu v
;nnv w
stringoo 
expressionTextoo !
;oo! "
usingpp 
(pp 
	XmlReaderpp 
expressionReaderpp -
=pp. /
catalogReaderpp0 =
.pp= >
ReadSubtreepp> I
(ppI J
)ppJ K
)ppK L
{qq 
expressionReaderrr  
.rr  !
Readrr! %
(rr% &
)rr& '
;rr' (
expressionTextss 
=ss  
ReadExpressionTextss! 3
(ss3 4
expressionReaderss4 D
)ssD E
.ssE F
TrimssF J
(ssJ K
)ssK L
;ssL M
}tt 
ifvv 
(vv 
expressionTextvv 
.vv 
Lengthvv %
==vv& (
$numvv) *
||vv+ -
expressionTextww 
.ww 
Lengthww %
>ww& ' 
ChatCatalogReadStateww( <
.ww< =*
MaximumCatalogExpressionLengthww= [
)ww[ \
{xx 
throwyy 
CatalogErroryy "
(yy" #
catalogReaderyy# 0
,yy0 1
$stryy2 m
)yym n
;yyn o
}zz 
return|| 
new|| $
ProhibitedChatExpression|| /
{}} 
ExpressionText~~ 
=~~  
expressionText~~! /
,~~/ 0!
ExpressionCultureName %
=& '
cultureName( 3
,3 4 
InfractionCategory
ÄÄ "
=
ÄÄ# $ 
infractionCategory
ÄÄ% 7
,
ÄÄ7 8'
CanMatchObfuscatedLetters
ÅÅ )
=
ÅÅ* +!
canMatchObfuscation
ÅÅ, ?
}
ÇÇ 
;
ÇÇ 
}
ÉÉ 	
private
ÖÖ 
static
ÖÖ 
string
ÖÖ  
ReadExpressionText
ÖÖ 0
(
ÖÖ0 1
	XmlReader
ÖÖ1 :
expressionReader
ÖÖ; K
)
ÖÖK L
{
ÜÜ 	
StringBuilder
áá 
expressionText
áá (
=
áá) *
new
áá+ .
StringBuilder
áá/ <
(
áá< =
)
áá= >
;
áá> ?
char
àà 
[
àà 
]
àà "
expressionTextBuffer
àà '
=
àà( )
new
àà* -
char
àà. 2
[
àà2 3"
ChatCatalogReadState
àà3 G
.
ààG H,
MaximumCatalogExpressionLength
ààH f
]
ààf g
;
ààg h
while
ââ 
(
ââ 
expressionReader
ââ #
.
ââ# $
Read
ââ$ (
(
ââ( )
)
ââ) *
)
ââ* +
{
ää 
if
ãã 
(
ãã 
expressionReader
ãã $
.
ãã$ %
NodeType
ãã% -
==
ãã. 0
XmlNodeType
ãã1 <
.
ãã< =
Text
ãã= A
||
ããB D
expressionReader
ããE U
.
ããU V
NodeType
ããV ^
==
ãã_ a
XmlNodeType
ããb m
.
ããm n
CDATA
ããn s
||
ããt v
expressionReader
åå $
.
åå$ %
NodeType
åå% -
==
åå. 0
XmlNodeType
åå1 <
.
åå< =#
SignificantWhitespace
åå= R
)
ååR S
{
çç "
AppendExpressionText
éé (
(
éé( )
expressionReader
éé) 9
,
éé9 :
expressionText
éé; I
,
ééI J"
expressionTextBuffer
ééK _
)
éé_ `
;
éé` a
}
èè 
else
êê 
if
êê 
(
êê 
expressionReader
êê )
.
êê) *
NodeType
êê* 2
==
êê3 5
XmlNodeType
êê6 A
.
êêA B
Element
êêB I
)
êêI J
{
ëë 
throw
íí 
CatalogError
íí &
(
íí& '
expressionReader
íí' 7
,
íí7 8
$str
íí9 p
)
ííp q
;
ííq r
}
ìì 
}
îî 
return
ññ 
expressionText
ññ !
.
ññ! "
ToString
ññ" *
(
ññ* +
)
ññ+ ,
;
ññ, -
}
óó 	
private
ôô 
static
ôô 
void
ôô "
AppendExpressionText
ôô 0
(
ôô0 1
	XmlReader
ôô1 :
expressionReader
ôô; K
,
ôôK L
StringBuilder
ôôM Z
expressionText
ôô[ i
,
ôôi j
char
öö 
[
öö 
]
öö "
expressionTextBuffer
öö '
)
öö' (
{
õõ 	
int
úú  
readCharacterCount
úú "
=
úú# $
expressionReader
úú% 5
.
úú5 6
ReadValueChunk
úú6 D
(
úúD E"
expressionTextBuffer
ùù $
,
ùù$ %
$num
ùù& '
,
ùù' ("
expressionTextBuffer
ùù) =
.
ùù= >
Length
ùù> D
)
ùùD E
;
ùùE F
while
ûû 
(
ûû  
readCharacterCount
ûû %
>
ûû& '
$num
ûû( )
)
ûû) *
{
üü 
if
†† 
(
†† 
expressionText
†† "
.
††" #
Length
††# )
+
††* + 
readCharacterCount
††, >
>
††? @"
ChatCatalogReadState
††A U
.
††U V,
MaximumCatalogExpressionLength
††V t
)
††t u
{
°° 
throw
¢¢ 
CatalogError
¢¢ &
(
¢¢& '
expressionReader
¢¢' 7
,
¢¢7 8
$str
¢¢9 h
)
¢¢h i
;
¢¢i j
}
££ 
expressionText
•• 
.
•• 
Append
•• %
(
••% &"
expressionTextBuffer
••& :
,
••: ;
$num
••< =
,
••= > 
readCharacterCount
••? Q
)
••Q R
;
••R S 
readCharacterCount
¶¶ "
=
¶¶# $
expressionReader
¶¶% 5
.
¶¶5 6
ReadValueChunk
¶¶6 D
(
¶¶D E"
expressionTextBuffer
ßß (
,
ßß( )
$num
ßß* +
,
ßß+ ,"
expressionTextBuffer
ßß- A
.
ßßA B
Length
ßßB H
)
ßßH I
;
ßßI J
}
®® 
}
©© 	
private
´´ 
static
´´ $
ChatInfractionCategory
´´ -
ReadCategory
´´. :
(
´´: ;
	XmlReader
´´; D
catalogReader
´´E R
)
´´R S
{
¨¨ 	$
ChatInfractionCategory
≠≠ " 
infractionCategory
≠≠# 5
;
≠≠5 6
switch
ÆÆ 
(
ÆÆ 
catalogReader
ÆÆ !
.
ÆÆ! "
GetAttribute
ÆÆ" .
(
ÆÆ. /
$str
ÆÆ/ 9
)
ÆÆ9 :
)
ÆÆ: ;
{
ØØ 
case
∞∞ 
$str
∞∞  
:
∞∞  ! 
infractionCategory
∞∞" 4
=
∞∞5 6$
ChatInfractionCategory
∞∞7 M
.
∞∞M N
	Profanity
∞∞N W
;
∞∞W X
break
∞∞Y ^
;
∞∞^ _
case
±± 
$str
±± 
:
±±  
infractionCategory
±± 1
=
±±2 3$
ChatInfractionCategory
±±4 J
.
±±J K
Threat
±±K Q
;
±±Q R
break
±±S X
;
±±X Y
default
≤≤ 
:
≤≤ 
throw
≤≤ 
CatalogError
≤≤ +
(
≤≤+ ,
catalogReader
≤≤, 9
,
≤≤9 :
$str
≤≤; q
)
≤≤q r
;
≤≤r s
}
≥≥ 
return
µµ  
infractionCategory
µµ %
;
µµ% &
}
∂∂ 	
private
∏∏ 
static
∏∏ "
InvalidDataException
∏∏ +
CatalogError
∏∏, 8
(
∏∏8 9
	XmlReader
∏∏9 B
catalogReader
∏∏C P
,
∏∏P Q
string
∏∏R X%
validationFailureReason
∏∏Y p
)
∏∏p q
{
ππ 	
IXmlLineInfo
∫∫ 
location
∫∫ !
=
∫∫" #
catalogReader
∫∫$ 1
as
∫∫2 4
IXmlLineInfo
∫∫5 A
;
∫∫A B
return
ªª 
new
ªª "
InvalidDataException
ªª +
(
ªª+ ,
string
ªª, 2
.
ªª2 3
Format
ªª3 9
(
ªª9 :
CultureInfo
ªª: E
.
ªªE F
InvariantCulture
ªªF V
,
ªªV W
$str
ºº ,
,
ºº, -
new
ΩΩ 
object
ΩΩ 
[
ΩΩ 
]
ΩΩ 
{
ΩΩ %
validationFailureReason
ΩΩ 6
,
ΩΩ6 7
catalogReader
ΩΩ8 E
.
ΩΩE F
BaseURI
ΩΩF M
,
ΩΩM N
location
ΩΩO W
?
ΩΩW X
.
ΩΩX Y

LineNumber
ΩΩY c
??
ΩΩd f
$num
ΩΩg h
}
ΩΩi j
)
ΩΩj k
)
ΩΩk l
;
ΩΩl m
}
ææ 	
}
øø 
}¿¿ à-
hC:\Users\oscar\source\repos\TrickTakingMissions\Server\Infrastructure.Moderation\ChatCatalogReadState.cs
	namespace 	
Infrastructure
 
. 

Moderation #
{ 
internal		 
sealed		 
class		  
ChatCatalogReadState		 .
{

 
internal 
const 
int !
MaximumCatalogEntries 0
=1 2
$num3 7
;7 8
internal 
const 
int *
MaximumCatalogExpressionLength 9
=: ;
$num< ?
;? @
private 
const 
int .
"MaximumNormalizedCatalogCharacters <
== >
$num? D
;D E
private 
readonly 

Dictionary #
<# $
string$ *
,* +$
ProhibitedChatExpression, D
>D E)
_catalogExpressionsByIdentityF c
=d e
new 

Dictionary 
< 
string !
,! "$
ProhibitedChatExpression# ;
>; <
(< =
)= >
;> ?
private 
readonly %
ChatMessageTextNormalizer 2&
_chatMessageTextNormalizer3 M
=N O
newP S%
ChatMessageTextNormalizerT m
(m n
)n o
;o p
private 
int 
_catalogEntryCount &
;& '
private 
int ,
 _normalizedCatalogCharacterCount 4
;4 5
internal 
IReadOnlyCollection $
<$ %$
ProhibitedChatExpression% =
>= >
Expressions? J
=>K M
new 
List 
< $
ProhibitedChatExpression -
>- .
(. /)
_catalogExpressionsByIdentity/ L
.L M
ValuesM S
)S T
.T U

AsReadOnlyU _
(_ `
)` a
;a b
internal 
void 
AddExpression #
(# $$
ProhibitedChatExpression$ <

expression= G
)G H
{ 	
_catalogEntryCount 
++  
;  !
string $
normalizedExpressionText +
=, -&
_chatMessageTextNormalizer. H
. $
NormalizeChatMessageText )
() *

expression* 4
.4 5
ExpressionText5 C
)C D
. %
ComparableChatMessageText *
;* +
ValidateEntryBudget 
(  $
normalizedExpressionText  8
)8 9
;9 :
string 
expressionIdentity %
=& '

expression( 2
.2 3!
ExpressionCultureName3 H
+I J
$strK N
+O P$
normalizedExpressionTextQ i
;i j$
ProhibitedChatExpression   $
previousExpression  % 7
;  7 8
if!! 
(!! )
_catalogExpressionsByIdentity!! -
.!!- .
TryGetValue!!. 9
(!!9 :
expressionIdentity!!: L
,!!L M
out!!N Q
previousExpression!!R d
)!!d e
)!!e f
{"" 
ValidateDuplicate## !
(##! "
previousExpression##" 4
,##4 5

expression##6 @
)##@ A
;##A B
}$$ 
else%% 
{&& ,
 _normalizedCatalogCharacterCount'' 0
+=''1 3$
normalizedExpressionText''4 L
.''L M
Length''M S
;''S T)
_catalogExpressionsByIdentity(( -
.((- .
Add((. 1
(((1 2
expressionIdentity((2 D
,((D E

expression((F P
)((P Q
;((Q R
})) 
}** 	
private,, 
void,, 
ValidateEntryBudget,, (
(,,( )
string,,) /$
normalizedExpressionText,,0 H
),,H I
{-- 	
if.. 
(.. 
_catalogEntryCount.. "
>..# $!
MaximumCatalogEntries..% :
||..; =$
normalizedExpressionText..> V
...V W
Length..W ]
==..^ `
$num..a b
||..c e$
normalizedExpressionText// (
.//( )
Length//) /
>//0 1*
MaximumCatalogExpressionLength//2 P
||//Q S,
 _normalizedCatalogCharacterCount00 0
+001 2$
normalizedExpressionText003 K
.00K L
Length00L R
>00S T.
"MaximumNormalizedCatalogCharacters00U w
)00w x
{11 
throw22 
new22  
InvalidDataException22 .
(22. /
$str22/ n
)22n o
;22o p
}33 
}44 	
private66 
static66 
void66 
ValidateDuplicate66 -
(66- .$
ProhibitedChatExpression66. F
previousExpression66G Y
,66Y Z$
ProhibitedChatExpression77 $

expression77% /
)77/ 0
{88 	
if99 
(99 
previousExpression99 "
.99" #
InfractionCategory99# 5
!=996 8

expression999 C
.99C D
InfractionCategory99D V
||99W Y
previousExpression:: "
.::" #%
CanMatchObfuscatedLetters::# <
!=::= ?

expression::@ J
.::J K%
CanMatchObfuscatedLetters::K d
)::d e
{;; 
throw<< 
new<<  
InvalidDataException<< .
(<<. /
$str<</ r
)<<r s
;<<s t
}== 
}>> 	
}?? 
}@@ 