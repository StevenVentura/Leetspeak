--Author: Nøøblet-Gorefiend (Steven Ventura)
--Date created: 12/28/2013

--saved variables: LeetspeakOptions

--[[

4/4/2015: i want to add random hiragana so it looks like japanese rather than chinese
[]add (middle)Wo, (middle)No, (middle)to, (end of sentence) desu, (verbs) ru, na (na-adjectives), 
[check]Today i fixed the bracket issue
[]Make it so fractions and symbols are not replaced by kanji.
[check]also, replace periods with the japanese periods.

囗囘囙囚四囜囝回囟因囡团団囤囥囦囧囨囩囪囫囬园囮囯困囱囲図围囵囶囷囸囹固囻囼国图囿圀圁圂圃圄圅圆圇圈圉圊國圌圍圎圏圐圑園圓圔圕圖圗團圙圚圛圜圝圞

--]]

local nameModes = {["DEFAULT"]=1,["LEETSPEAK"]=2,["ENGRISH"]=3,["CHINGCHONG"]=4};
local modeNames = {[1]="DEFAULT",[2]="LEETSPEAK",[3]="ENGRISH",[4]="CHINGCHONG"};
local specialLeetspeakModeName = {[1]="Normal",
								[2]="LЭЭ7",
								[3]="乚当当干",
								[4]="驫繰総麤"};
leetspeak_bgframe = CreateFrame('Frame','leetspeak_bgframe',UIParent);
leetspeak_bgframe:SetPoint("TOPRIGHT",ChatFrame1,"TOPRIGHT",0,0)
leetspeak_bgframe:Hide();
Leetspeak = CreateFrame("FRAME");
Leetspeak:SetScript("OnUpdate", function(self, elapsed) LeetspeakOnUpdate(self, elapsed) end)


SLASH_LEETSPEAK1 = '/leetspeak';
SlashCmdList["LEETSPEAK"]=slashleetspeak;

speakEnabled = 1--2 is on, 1 is off. 3 is japSpeak, 4 is random Kanji.

insideSquareBrackets = 0--0 is false, 1 is true. if true, then don't convert text inside brackets.
function slashleetspeak(msg, editBox)
	local command, rest = msg:match("^(%S*)%s*(.-)$");
print("|cffff8800Leetspeak: click on the lil popup thinger when you hit enter to change your text mode xd")
	

	
end

LeetspeakTimeElapsed = 0;

function LeetspeakOnUpdate(self, elapsed)
LeetspeakTimeElapsed = LeetspeakTimeElapsed + elapsed;
if (LeetspeakTimeElapsed > 1/2) then
LeetspeakTimeElapsed = 0;
if (ChatFrame1EditBox:HasFocus()) then
leetspeak_bgframe:Show();
else
leetspeak_bgframe:Hide();
end

end

end--end function LeetspeakOnUpdate

--------------------------------------------------------------------

-- UTF-8 Reference:
-- 0xxxxxxx - 1 byte UTF-8 codepoint (ASCII character)
-- 110yyyxx - First byte of a 2 byte UTF-8 codepoint
-- 1110yyyy - First byte of a 3 byte UTF-8 codepoint
-- 11110zzz - First byte of a 4 byte UTF-8 codepoint
-- 10xxxxxx - Inner byte of a multi-byte UTF-8 codepoint
 
local function chsize(char)
    if not char then
        return 0
    elseif char > 240 then
        return 4
    elseif char > 225 then
        return 3
    elseif char > 192 then
        return 2
    else
        return 1
    end
end
 
-- This function can return a substring of a UTF-8 string, properly handling
-- UTF-8 codepoints.  Rather than taking a start index and optionally an end
-- index, it takes the string, the starting character, and the number of
-- characters to select from the string.
 
local function utf8sub(str, startChar, numChars)
  local startIndex = 1
  while startChar > 1 do
      local char = string.byte(str, startIndex)
      startIndex = startIndex + chsize(char)
      startChar = startChar - 1
  end
 
  local currentIndex = startIndex
 
  while numChars > 0 and currentIndex <= #str do
    local char = string.byte(str, currentIndex)
    currentIndex = currentIndex + chsize(char)
    numChars = numChars -1
  end
  return str:sub(startIndex, currentIndex - 1)
end

--------------------------------------------------------------------
--note: i (steven) copied the below utf-8 code snippets from https://github.com/alexander-yakushev/awesompd/blob/master/utf8.lua
--note: i coped it on january 7, 2014 at 3 pm central
--[[
Copyright (c) 2006-2007, Kyle Smith
Modified by Alexander Yakushev, 2010-2013.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice,
this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.
* Neither the name of the author nor the names of its contributors may be
used to endorse or promote products derived from this software without
specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--]]
------------------------------------------------------------------------------------------
local utf8 = {}

function utf8.charbytes (s, i)
   -- argument defaults
   i = i or 1
   local c = string.byte(s, i)
   
   -- determine bytes needed for character, based on RFC 3629
   if c > 0 and c <= 127 then
      -- UTF8-1
      return 1
   elseif c >= 194 and c <= 223 then
      -- UTF8-2
      local c2 = string.byte(s, i + 1)
      return 2
   elseif c >= 224 and c <= 239 then
      -- UTF8-3
      local c2 = s:byte(i + 1)
      local c3 = s:byte(i + 2)
      return 3
   elseif c >= 240 and c <= 244 then
      -- UTF8-4
      local c2 = s:byte(i + 1)
      local c3 = s:byte(i + 2)
      local c4 = s:byte(i + 3)
      return 4
   end
end

-- returns the number of characters in a UTF-8 string
function utf8.len (s)
   local pos = 1
   local bytes = string.len(s)
   local len = 0
   
   while pos <= bytes and len ~= chars do
      local c = string.byte(s,pos)
      len = len + 1
      
      pos = pos + utf8.charbytes(s, pos)
   end
   
   if chars ~= nil then
      return pos - 1
   end
   
   return len
end

-- functions identically to string.sub except that i and j are UTF-8 characters
-- instead of bytes
function utf8.sub (s, i, j)
   j = j or -1

   if i == nil then
      return ""
   end
   
   local pos = 1
   local bytes = string.len(s)
   local len = 0

   -- only set l if i or j is negative
   local l = (i >= 0 and j >= 0) or utf8.len(s)
   local startChar = (i >= 0) and i or l + i + 1
   local endChar = (j >= 0) and j or l + j + 1

   -- can't have start before end!
   if startChar > endChar then
      return ""
   end
   
   -- byte offsets to pass to string.sub
   local startByte, endByte = 1, bytes
   
   while pos <= bytes do
      len = len + 1
      
      if len == startChar then
         startByte = pos
      end
      
      pos = pos + utf8.charbytes(s, pos)
      
      if len == endChar then
         endByte = pos - 1
         break
      end
   end
   
   return string.sub(s, startByte, endByte)
end
---------------------------------------------------------------------------------------------------

kanjiMegaString = "一丁丂七丄丅丆万丈三上下丌不与丏丐丑丒专且丕世丗丘丙业丛东丝丞丟丠両丢丣两严並丧丨丩个丫丬中丮丯丰丱串丳临丵丶丷丸丹为主丼丽举丿乀乁乂乃乄久乆乇么义乊之乌乍乎乏乐乑乒乓乔乕乖乗乘乙乚乛乜九乞也习乡乢乣乤乥书乧乨乩乪乫乬乭乮乯买乱乲乳乴乵乶乷乸乹乺乻乼乽乾乿亀亁亂亃亄亅了亇予争亊事二亍于亏亐云互亓五井亖亗亘亙亚些亜亝亞亟亠亡亢亣交亥亦产亨亩亪享京亭亮亯亰亱亲亳亴亵亶亷亸亹人亻亼亽亾亿什仁仂仃仄仅仆仇仈仉今介仌仍从仏仐仑仒仓仔仕他仗付仙仚仛仜仝仞仟仠仡仢代令以仦仧仨仩仪仫们仭仮仯仰仱仲仳仴仵件价仸仹仺任仼份仾仿伀企伂伃伄伅伆伇伈伉伊伋伌伍伎伏伐休伒伓伔伕伖众优伙会伛伜伝伞伟传伡伢伣伤伥伦伧伨伩伪伫伬伭伮伯估伱伲伳伴伵伶伷伸伹伺伻似伽伾伿佀佁佂佃佄佅但佇佈佉佊佋佌位低住佐佑佒体佔何佖佗佘余佚佛作佝佞佟你佡佢佣佤佥佦佧佨佩佪佫佬佭佮佯佰佱佲佳佴併佶佷佸佹佺佻佼佽佾使侀侁侂侃侄侅來侇侈侉侊例侌侍侎侏侐侑侒侓侔侕侖侗侘侙侚供侜依侞侟侠価侢侣侤侥侦侧侨侩侪侫侬侭侮侯侰侱侲侳侴侵侶侷侸侹侺侻侼侽侾便俀俁係促俄俅俆俇俈俉俊俋俌俍俎俏俐俑俒俓俔俕俖俗俘俙俚俛俜保俞俟俠信俢俣俤俥俦俧俨俩俪俫俬俭修俯俰俱俲俳俴俵俶俷俸俹俺俻俼俽俾俿倀倁倂倃倄倅倆倇倈倉倊個倌倍倎倏倐們倒倓倔倕倖倗倘候倚倛倜倝倞借倠倡倢倣値倥倦倧倨倩倪倫倬倭倮倯倰倱倲倳倴倵倶倷倸倹债倻值倽倾倿偀偁偂偃偄偅偆假偈偉偊偋偌偍偎偏偐偑偒偓偔偕偖偗偘偙做偛停偝偞偟偠偡偢偣偤健偦偧偨偩偪偫偬偭偮偯偰偱偲偳側偵偶偷偸偹偺偻偼偽偾偿傀傁傂傃傄傅傆傇傈傉傊傋傌傍傎傏傐傑傒傓傔傕傖傗傘備傚傛傜傝傞傟傠傡傢傣傤傥傦傧储傩傪傫催傭傮傯傰傱傲傳傴債傶傷傸傹傺傻傼傽傾傿僀僁僂僃僄僅僆僇僈僉僊僋僌働僎像僐僑僒僓僔僕僖僗僘僙僚僛僜僝僞僟僠僡僢僣僤僥僦僧僨僩僪僫僬僭僮僯僰僱僲僳僴僵僶僷僸價僺僻僼僽僾僿儀儁儂儃億儅儆儇儈儉儊儋儌儍儎儏儐儑儒儓儔儕儖儗儘儙儚儛儜儝儞償儠儡儢儣儤儥儦儧儨儩優儫儬儭儮儯儰儱儲儳儴儵儶儷儸儹儺儻儼儽儾儿兀允兂元兄充兆兇先光兊克兌免兎兏児兑兒兓兔兕兖兗兘兙党兛兜兝兞兟兠兡兢兣兤入兦內全兩兪八公六兮兯兰共兲关兴兵其具典兹兺养兼兽兾兿冀冁冂冃冄内円冇冈冉冊冋册再冎冏冐冑冒冓冔冕冖冗冘写冚军农冝冞冟冠冡冢冣冤冥冦冧冨冩冪冫冬冭冮冯冰冱冲决冴况冶冷冸冹冺冻冼冽冾冿净凁凂凃凄凅准凇凈凉凊凋凌凍凎减凐凑凒凓凔凕凖凗凘凙凚凛凜凝凞凟几凡凢凣凤凥処凧凨凩凪凫凬凭凮凯凰凱凲凳凴凵凶凷凸凹出击凼函凾凿刀刁刂刃刄刅分切刈刉刊刋刌刍刎刏刐刑划刓刔刕刖列刘则刚创刜初刞刟删刡刢刣判別刦刧刨利刪别刬刭刮刯到刱刲刳刴刵制刷券刹刺刻刼刽刾刿剀剁剂剃剄剅剆則剈剉削剋剌前剎剏剐剑剒剓剔剕剖剗剘剙剚剛剜剝剞剟剠剡剢剣剤剥剦剧剨剩剪剫剬剭剮副剰剱割剳剴創剶剷剸剹剺剻剼剽剾剿劀劁劂劃劄劅劆劇劈劉劊劋劌劍劎劏劐劑劒劓劔劕劖劗劘劙劚力劜劝办功加务劢劣劤劥劦劧动助努劫劬劭劮劯劰励劲劳労劵劶劷劸効劺劻劼劽劾势勀勁勂勃勄勅勆勇勈勉勊勋勌勍勎勏勐勑勒勓勔動勖勗勘務勚勛勜勝勞募勠勡勢勣勤勥勦勧勨勩勪勫勬勭勮勯勰勱勲勳勴勵勶勷勸勹勺勻勼勽勾勿匀匁匂匃匄包匆匇匈匉匊匋匌匍匎匏匐匑匒匓匔匕化北匘匙匚匛匜匝匞匟匠匡匢匣匤匥匦匧匨匩匪匫匬匭匮匯匰匱匲匳匴匵匶匷匸匹区医匼匽匾匿區十卂千卄卅卆升午卉半卋卌卍华协卐卑卒卓協单卖南単卙博卛卜卝卞卟占卡卢卣卤卥卦卧卨卩卪卫卬卭卮卯印危卲即却卵卶卷卸卹卺卻卼卽卾卿厀厁厂厃厄厅历厇厈厉厊压厌厍厎厏厐厑厒厓厔厕厖厗厘厙厚厛厜厝厞原厠厡厢厣厤厥厦厧厨厩厪厫厬厭厮厯厰厱厲厳厴厵厶厷厸厹厺去厼厽厾县叀叁参參叄叅叆叇又叉及友双反収叏叐发叒叓叔叕取受变叙叚叛叜叝叞叟叠叡叢口古句另叧叨叩只叫召叭叮可台叱史右叴叵叶号司叹叺叻叼叽叾叿吀吁吂吃各吅吆吇合吉吊吋同名后吏吐向吒吓吔吕吖吗吘吙吚君吜吝吞吟吠吡吢吣吤吥否吧吨吩吪含听吭吮启吰吱吲吳吴吵吶吷吸吹吺吻吼吽吾吿呀呁呂呃呄呅呆呇呈呉告呋呌呍呎呏呐呑呒呓呔呕呖呗员呙呚呛呜呝呞呟呠呡呢呣呤呥呦呧周呩呪呫呬呭呮呯呰呱呲味呴呵呶呷呸呹呺呻呼命呾呿咀咁咂咃咄咅咆咇咈咉咊咋和咍咎咏咐咑咒咓咔咕咖咗咘咙咚咛咜咝咞咟咠咡咢咣咤咥咦咧咨咩咪咫咬咭咮咯咰咱咲咳咴咵咶咷咸咹咺咻咼咽咾咿哀品哂哃哄哅哆哇哈哉哊哋哌响哎哏哐哑哒哓哔哕哖哗哘哙哚哛哜哝哞哟哠員哢哣哤哥哦哧哨哩哪哫哬哭哮哯哰哱哲哳哴哵哶哷哸哹哺哻哼哽哾哿唀唁唂唃唄唅唆唇唈唉唊唋唌唍唎唏唐唑唒唓唔唕唖唗唘唙唚唛唜唝唞唟唠唡唢唣唤唥唦唧唨唩唪唫唬唭售唯唰唱唲唳唴唵唶唷唸唹唺唻唼唽唾唿啀啁啂啃啄啅商啇啈啉啊啋啌啍啎問啐啑啒啓啔啕啖啗啘啙啚啛啜啝啞啟啠啡啢啣啤啥啦啧啨啩啪啫啬啭啮啯啰啱啲啳啴啵啶啷啸啹啺啻啼啽啾啿喀喁喂喃善喅喆喇喈喉喊喋喌喍喎喏喐喑喒喓喔喕喖喗喘喙喚喛喜喝喞喟喠喡喢喣喤喥喦喧喨喩喪喫喬喭單喯喰喱喲喳喴喵営喷喸喹喺喻喼喽喾喿嗀嗁嗂嗃嗄嗅嗆嗇嗈嗉嗊嗋嗌嗍嗎嗏嗐嗑嗒嗓嗔嗕嗖嗗嗘嗙嗚嗛嗜嗝嗞嗟嗠嗡嗢嗣嗤嗥嗦嗧嗨嗩嗪嗫嗬嗭嗮嗯嗰嗱嗲嗳嗴嗵嗶嗷嗸嗹嗺嗻嗼嗽嗾嗿嘀嘁嘂嘃嘄嘅嘆嘇嘈嘉嘊嘋嘌嘍嘎嘏嘐嘑嘒嘓嘔嘕嘖嘗嘘嘙嘚嘛嘜嘝嘞嘟嘠嘡嘢嘣嘤嘥嘦嘧嘨嘩嘪嘫嘬嘭嘮嘯嘰嘱嘲嘳嘴嘵嘶嘷嘸嘹嘺嘻嘼嘽嘾嘿噀噁噂噃噄噅噆噇噈噉噊噋噌噍噎噏噐噑噒噓噔噕噖噗噘噙噚噛噜噝噞噟噠噡噢噣噤噥噦噧器噩噪噫噬噭噮噯噰噱噲噳噴噵噶噷噸噹噺噻噼噽噾噿嚀嚁嚂嚃嚄嚅嚆嚇嚈嚉嚊嚋嚌嚍嚎嚏嚐嚑嚒嚓嚔嚕嚖嚗嚘嚙嚚嚛嚜嚝嚞嚟嚠嚡嚢嚣嚤嚥嚦嚧嚨嚩嚪嚫嚬嚭嚮嚯嚰嚱嚲嚳嚴嚵嚶嚷嚸嚹嚺嚻嚼嚽嚾嚿囀囁囂囃囄囅囆囇囈囉囊囋囌囍囎囏囐囑囒囓囔囕囖囗囘囙囚四囜囝回囟因囡团団囤囥囦囧囨囩囪囫囬园囮囯困囱囲図围囵囶囷囸囹固囻囼国图囿圀圁圂圃圄圅圆圇圈圉圊國圌圍圎圏圐圑園圓圔圕圖圗團圙圚圛圜圝圞土圠圡圢圣圤圥圦圧在圩圪圫圬圭圮圯地圱圲圳圴圵圶圷圸圹场圻圼圽圾圿址坁坂坃坄坅坆均坈坉坊坋坌坍坎坏坐坑坒坓坔坕坖块坘坙坚坛坜坝坞坟坠坡坢坣坤坥坦坧坨坩坪坫坬坭坮坯坰坱坲坳坴坵坶坷坸坹坺坻坼坽坾坿垀垁垂垃垄垅垆垇垈垉垊型垌垍垎垏垐垑垒垓垔垕垖垗垘垙垚垛垜垝垞垟垠垡垢垣垤垥垦垧垨垩垪垫垬垭垮垯垰垱垲垳垴垵垶垷垸垹垺垻垼垽垾垿埀埁埂埃埄埅埆埇埈埉埊埋埌埍城埏埐埑埒埓埔埕埖埗埘埙埚埛埜埝埞域埠埡埢埣埤埥埦埧埨埩埪埫埬埭埮埯埰埱埲埳埴埵埶執埸培基埻埼埽埾埿堀堁堂堃堄堅堆堇堈堉堊堋堌堍堎堏堐堑堒堓堔堕堖堗堘堙堚堛堜堝堞堟堠堡堢堣堤堥堦堧堨堩堪堫堬堭堮堯堰報堲堳場堵堶堷堸堹堺堻堼堽堾堿塀塁塂塃塄塅塆塇塈塉塊塋塌塍塎塏塐塑塒塓塔塕塖塗塘塙塚塛塜塝塞塟塠塡塢塣塤塥塦塧塨塩塪填塬塭塮塯塰塱塲塳塴塵塶塷塸塹塺塻塼塽塾塿墀墁墂境墄墅墆墇墈墉墊墋墌墍墎墏墐墑墒墓墔墕墖増墘墙墚墛墜墝增墟墠墡墢墣墤墥墦墧墨墩墪墫墬墭墮墯墰墱墲墳墴墵墶墷墸墹墺墻墼墽墾墿壀壁壂壃壄壅壆壇壈壉壊壋壌壍壎壏壐壑壒壓壔壕壖壗壘壙壚壛壜壝壞壟壠壡壢壣壤壥壦壧壨壩壪士壬壭壮壯声壱売壳壴壵壶壷壸壹壺壻壼壽壾壿夀夁夂夃处夅夆备夈変夊夋夌复夎夏夐夑夒夓夔夕外夗夘夙多夛夜夝夞够夠夡夢夣夤夥夦大夨天太夫夬夭央夯夰失夲夳头夵夶夷夸夹夺夻夼夽夾夿奀奁奂奃奄奅奆奇奈奉奊奋奌奍奎奏奐契奒奓奔奕奖套奘奙奚奛奜奝奞奟奠奡奢奣奤奥奦奧奨奩奪奫奬奭奮奯奰奱奲女奴奵奶奷奸她奺奻奼好奾奿妀妁如妃妄妅妆妇妈妉妊妋妌妍妎妏妐妑妒妓妔妕妖妗妘妙妚妛妜妝妞妟妠妡妢妣妤妥妦妧妨妩妪妫妬妭妮妯妰妱妲妳妴妵妶妷妸妹妺妻妼妽妾妿姀姁姂姃姄姅姆姇姈姉姊始姌姍姎姏姐姑姒姓委姕姖姗姘姙姚姛姜姝姞姟姠姡姢姣姤姥姦姧姨姩姪姫姬姭姮姯姰姱姲姳姴姵姶姷姸姹姺姻姼姽姾姿娀威娂娃娄娅娆娇娈娉娊娋娌娍娎娏娐娑娒娓娔娕娖娗娘娙娚娛娜娝娞娟娠娡娢娣娤娥娦娧娨娩娪娫娬娭娮娯娰娱娲娳娴娵娶娷娸娹娺娻娼娽娾娿婀婁婂婃婄婅婆婇婈婉婊婋婌婍婎婏婐婑婒婓婔婕婖婗婘婙婚婛婜婝婞婟婠婡婢婣婤婥婦婧婨婩婪婫婬婭婮婯婰婱婲婳婴婵婶婷婸婹婺婻婼婽婾婿媀媁媂媃媄媅媆媇媈媉媊媋媌媍媎媏媐媑媒媓媔媕媖媗媘媙媚媛媜媝媞媟媠媡媢媣媤媥媦媧媨媩媪媫媬媭媮媯媰媱媲媳媴媵媶媷媸媹媺媻媼媽媾媿嫀嫁嫂嫃嫄嫅嫆嫇嫈嫉嫊嫋嫌嫍嫎嫏嫐嫑嫒嫓嫔嫕嫖嫗嫘嫙嫚嫛嫜嫝嫞嫟嫠嫡嫢嫣嫤嫥嫦嫧嫨嫩嫪嫫嫬嫭嫮嫯嫰嫱嫲嫳嫴嫵嫶嫷嫸嫹嫺嫻嫼嫽嫾嫿嬀嬁嬂嬃嬄嬅嬆嬇嬈嬉嬊嬋嬌嬍嬎嬏嬐嬑嬒嬓嬔嬕嬖嬗嬘嬙嬚嬛嬜嬝嬞嬟嬠嬡嬢嬣嬤嬥嬦嬧嬨嬩嬪嬫嬬嬭嬮嬯嬰嬱嬲嬳嬴嬵嬶嬷嬸嬹嬺嬻嬼嬽嬾嬿孀孁孂孃孄孅孆孇孈孉孊孋孌孍孎孏子孑孒孓孔孕孖字存孙孚孛孜孝孞孟孠孡孢季孤孥学孧孨孩孪孫孬孭孮孯孰孱孲孳孴孵孶孷學孹孺孻孼孽孾孿宀宁宂它宄宅宆宇守安宊宋完宍宎宏宐宑宒宓宔宕宖宗官宙定宛宜宝实実宠审客宣室宥宦宧宨宩宪宫宬宭宮宯宰宱宲害宴宵家宷宸容宺宻宼宽宾宿寀寁寂寃寄寅密寇寈寉寊寋富寍寎寏寐寑寒寓寔寕寖寗寘寙寚寛寜寝寞察寠寡寢寣寤寥實寧寨審寪寫寬寭寮寯寰寱寲寳寴寵寶寷寸对寺寻导寽対寿尀封専尃射尅将將專尉尊尋尌對導小尐少尒尓尔尕尖尗尘尙尚尛尜尝尞尟尠尡尢尣尤尥尦尧尨尩尪尫尬尭尮尯尰就尲尳尴尵尶尷尸尹尺尻尼尽尾尿局屁层屃屄居屆屇屈屉届屋屌屍屎屏屐屑屒屓屔展屖屗屘屙屚屛屜屝属屟屠屡屢屣層履屦屧屨屩屪屫屬屭屮屯屰山屲屳屴屵屶屷屸屹屺屻屼屽屾屿岀岁岂岃岄岅岆岇岈岉岊岋岌岍岎岏岐岑岒岓岔岕岖岗岘岙岚岛岜岝岞岟岠岡岢岣岤岥岦岧岨岩岪岫岬岭岮岯岰岱岲岳岴岵岶岷岸岹岺岻岼岽岾岿峀峁峂峃峄峅峆峇峈峉峊峋峌峍峎峏峐峑峒峓峔峕峖峗峘峙峚峛峜峝峞峟峠峡峢峣峤峥峦峧峨峩峪峫峬峭峮峯峰峱峲峳峴峵島峷峸峹峺峻峼峽峾峿崀崁崂崃崄崅崆崇崈崉崊崋崌崍崎崏崐崑崒崓崔崕崖崗崘崙崚崛崜崝崞崟崠崡崢崣崤崥崦崧崨崩崪崫崬崭崮崯崰崱崲崳崴崵崶崷崸崹崺崻崼崽崾崿嵀嵁嵂嵃嵄嵅嵆嵇嵈嵉嵊嵋嵌嵍嵎嵏嵐嵑嵒嵓嵔嵕嵖嵗嵘嵙嵚嵛嵜嵝嵞嵟嵠嵡嵢嵣嵤嵥嵦嵧嵨嵩嵪嵫嵬嵭嵮嵯嵰嵱嵲嵳嵴嵵嵶嵷嵸嵹嵺嵻嵼嵽嵾嵿嶀嶁嶂嶃嶄嶅嶆嶇嶈嶉嶊嶋嶌嶍嶎嶏嶐嶑嶒嶓嶔嶕嶖嶗嶘嶙嶚嶛嶜嶝嶞嶟嶠嶡嶢嶣嶤嶥嶦嶧嶨嶩嶪嶫嶬嶭嶮嶯嶰嶱嶲嶳嶴嶵嶶嶷嶸嶹嶺嶻嶼嶽嶾嶿巀巁巂巃巄巅巆巇巈巉巊巋巌巍巎巏巐巑巒巓巔巕巖巗巘巙巚巛巜川州巟巠巡巢巣巤工左巧巨巩巪巫巬巭差巯巰己已巳巴巵巶巷巸巹巺巻巼巽巾巿帀币市布帄帅帆帇师帉帊帋希帍帎帏帐帑帒帓帔帕帖帗帘帙帚帛帜帝帞帟帠帡帢帣帤帥带帧帨帩帪師帬席帮帯帰帱帲帳帴帵帶帷常帹帺帻帼帽帾帿幀幁幂幃幄幅幆幇幈幉幊幋幌幍幎幏幐幑幒幓幔幕幖幗幘幙幚幛幜幝幞幟幠幡幢幣幤幥幦幧幨幩幪幫幬幭幮幯幰幱干平年幵并幷幸幹幺幻幼幽幾广庀庁庂広庄庅庆庇庈庉床庋庌庍庎序庐庑庒库应底庖店庘庙庚庛府庝庞废庠庡庢庣庤庥度座庨庩庪庫庬庭庮庯庰庱庲庳庴庵庶康庸庹庺庻庼庽庾庿廀廁廂廃廄廅廆廇廈廉廊廋廌廍廎廏廐廑廒廓廔廕廖廗廘廙廚廛廜廝廞廟廠廡廢廣廤廥廦廧廨廩廪廫廬廭廮廯廰廱廲廳廴廵延廷廸廹建廻廼廽廾廿开弁异弃弄弅弆弇弈弉弊弋弌弍弎式弐弑弒弓弔引弖弗弘弙弚弛弜弝弞弟张弡弢弣弤弥弦弧弨弩弪弫弬弭弮弯弰弱弲弳弴張弶強弸弹强弻弼弽弾弿彀彁彂彃彄彅彆彇彈彉彊彋彌彍彎彏彐彑归当彔录彖彗彘彙彚彛彜彝彞彟彠彡形彣彤彥彦彧彨彩彪彫彬彭彮彯彰影彲彳彴彵彶彷彸役彺彻彼彽彾彿往征徂徃径待徆徇很徉徊律後徍徎徏徐徑徒従徔徕徖得徘徙徚徛徜徝從徟徠御徢徣徤徥徦徧徨復循徫徬徭微徯徰徱徲徳徴徵徶德徸徹徺徻徼徽徾徿忀忁忂心忄必忆忇忈忉忊忋忌忍忎忏忐忑忒忓忔忕忖志忘忙忚忛応忝忞忟忠忡忢忣忤忥忦忧忨忩忪快忬忭忮忯忰忱忲忳忴念忶忷忸忹忺忻忼忽忾忿怀态怂怃怄怅怆怇怈怉怊怋怌怍怎怏怐怑怒怓怔怕怖怗怘怙怚怛怜思怞怟怠怡怢怣怤急怦性怨怩怪怫怬怭怮怯怰怱怲怳怴怵怶怷怸怹怺总怼怽怾怿恀恁恂恃恄恅恆恇恈恉恊恋恌恍恎恏恐恑恒恓恔恕恖恗恘恙恚恛恜恝恞恟恠恡恢恣恤恥恦恧恨恩恪恫恬恭恮息恰恱恲恳恴恵恶恷恸恹恺恻恼恽恾恿悀悁悂悃悄悅悆悇悈悉悊悋悌悍悎悏悐悑悒悓悔悕悖悗悘悙悚悛悜悝悞悟悠悡悢患悤悥悦悧您悩悪悫悬悭悮悯悰悱悲悳悴悵悶悷悸悹悺悻悼悽悾悿惀惁惂惃惄情惆惇惈惉惊惋惌惍惎惏惐惑惒惓惔惕惖惗惘惙惚惛惜惝惞惟惠惡惢惣惤惥惦惧惨惩惪惫惬惭惮惯惰惱惲想惴惵惶惷惸惹惺惻惼惽惾惿愀愁愂愃愄愅愆愇愈愉愊愋愌愍愎意愐愑愒愓愔愕愖愗愘愙愚愛愜愝愞感愠愡愢愣愤愥愦愧愨愩愪愫愬愭愮愯愰愱愲愳愴愵愶愷愸愹愺愻愼愽愾愿慀慁慂慃慄慅慆慇慈慉慊態慌慍慎慏慐慑慒慓慔慕慖慗慘慙慚慛慜慝慞慟慠慡慢慣慤慥慦慧慨慩慪慫慬慭慮慯慰慱慲慳慴慵慶慷慸慹慺慻慼慽慾慿憀憁憂憃憄憅憆憇憈憉憊憋憌憍憎憏憐憑憒憓憔憕憖憗憘憙憚憛憜憝憞憟憠憡憢憣憤憥憦憧憨憩憪憫憬憭憮憯憰憱憲憳憴憵憶憷憸憹憺憻憼憽憾憿懀懁懂懃懄懅懆懇懈應懊懋懌懍懎懏懐懑懒懓懔懕懖懗懘懙懚懛懜懝懞懟懠懡懢懣懤懥懦懧懨懩懪懫懬懭懮懯懰懱懲懳懴懵懶懷懸懹懺懻懼懽懾懿戀戁戂戃戄戅戆戇戈戉戊戋戌戍戎戏成我戒戓戔戕或戗战戙戚戛戜戝戞戟戠戡戢戣戤戥戦戧戨戩截戫戬戭戮戯戰戱戲戳戴戵戶户戸戹戺戻戼戽戾房所扁扂扃扄扅扆扇扈扉扊手扌才扎扏扐扑扒打扔払扖扗托扙扚扛扜扝扞扟扠扡扢扣扤扥扦执扨扩扪扫扬扭扮扯扰扱扲扳扴扵扶扷扸批扺扻扼扽找承技抁抂抃抄抅抆抇抈抉把抋抌抍抎抏抐抑抒抓抔投抖抗折抙抚抛抜抝択抟抠抡抢抣护报抦抧抨抩抪披抬抭抮抯抰抱抲抳抴抵抶抷抸抹抺抻押抽抾抿拀拁拂拃拄担拆拇拈拉拊拋拌拍拎拏拐拑拒拓拔拕拖拗拘拙拚招拜拝拞拟拠拡拢拣拤拥拦拧拨择拪拫括拭拮拯拰拱拲拳拴拵拶拷拸拹拺拻拼拽拾拿挀持挂挃挄挅挆指挈按挊挋挌挍挎挏挐挑挒挓挔挕挖挗挘挙挚挛挜挝挞挟挠挡挢挣挤挥挦挧挨挩挪挫挬挭挮振挰挱挲挳挴挵挶挷挸挹挺挻挼挽挾挿捀捁捂捃捄捅捆捇捈捉捊捋捌捍捎捏捐捑捒捓捔捕捖捗捘捙捚捛捜捝捞损捠捡换捣捤捥捦捧捨捩捪捫捬捭据捯捰捱捲捳捴捵捶捷捸捹捺捻捼捽捾捿掀掁掂掃掄掅掆掇授掉掊掋掌掍掎掏掐掑排掓掔掕掖掗掘掙掚掛掜掝掞掟掠採探掣掤接掦控推掩措掫掬掭掮掯掰掱掲掳掴掵掶掷掸掹掺掻掼掽掾掿揀揁揂揃揄揅揆揇揈揉揊揋揌揍揎描提揑插揓揔揕揖揗揘揙揚換揜揝揞揟揠握揢揣揤揥揦揧揨揩揪揫揬揭揮揯揰揱揲揳援揵揶揷揸揹揺揻揼揽揾揿搀搁搂搃搄搅搆搇搈搉搊搋搌損搎搏搐搑搒搓搔搕搖搗搘搙搚搛搜搝搞搟搠搡搢搣搤搥搦搧搨搩搪搫搬搭搮搯搰搱搲搳搴搵搶搷搸搹携搻搼搽搾搿摀摁摂摃摄摅摆摇摈摉摊摋摌摍摎摏摐摑摒摓摔摕摖摗摘摙摚摛摜摝摞摟摠摡摢摣摤摥摦摧摨摩摪摫摬摭摮摯摰摱摲摳摴摵摶摷摸摹摺摻摼摽摾摿撀撁撂撃撄撅撆撇撈撉撊撋撌撍撎撏撐撑撒撓撔撕撖撗撘撙撚撛撜撝撞撟撠撡撢撣撤撥撦撧撨撩撪撫撬播撮撯撰撱撲撳撴撵撶撷撸撹撺撻撼撽撾撿擀擁擂擃擄擅擆擇擈擉擊擋擌操擎擏擐擑擒擓擔擕擖擗擘擙據擛擜擝擞擟擠擡擢擣擤擥擦擧擨擩擪擫擬擭擮擯擰擱擲擳擴擵擶擷擸擹擺擻擼擽擾擿攀攁攂攃攄攅攆攇攈攉攊攋攌攍攎攏攐攑攒攓攔攕攖攗攘攙攚攛攜攝攞攟攠攡攢攣攤攥攦攧攨攩攪攫攬攭攮支攰攱攲攳攴攵收攷攸改攺攻攼攽放政敀敁敂敃敄故敆敇效敉敊敋敌敍敎敏敐救敒敓敔敕敖敗敘教敚敛敜敝敞敟敠敡敢散敤敥敦敧敨敩敪敫敬敭敮敯数敱敲敳整敵敶敷數敹敺敻敼敽敾敿斀斁斂斃斄斅斆文斈斉斊斋斌斍斎斏斐斑斒斓斔斕斖斗斘料斚斛斜斝斞斟斠斡斢斣斤斥斦斧斨斩斪斫斬断斮斯新斱斲斳斴斵斶斷斸方斺斻於施斾斿旀旁旂旃旄旅旆旇旈旉旊旋旌旍旎族旐旑旒旓旔旕旖旗旘旙旚旛旜旝旞旟无旡既旣旤日旦旧旨早旪旫旬旭旮旯旰旱旲旳旴旵时旷旸旹旺旻旼旽旾旿昀昁昂昃昄昅昆昇昈昉昊昋昌昍明昏昐昑昒易昔昕昖昗昘昙昚昛昜昝昞星映昡昢昣昤春昦昧昨昩昪昫昬昭昮是昰昱昲昳昴昵昶昷昸昹昺昻昼昽显昿晀晁時晃晄晅晆晇晈晉晊晋晌晍晎晏晐晑晒晓晔晕晖晗晘晙晚晛晜晝晞晟晠晡晢晣晤晥晦晧晨晩晪晫晬晭普景晰晱晲晳晴晵晶晷晸晹智晻晼晽晾晿暀暁暂暃暄暅暆暇暈暉暊暋暌暍暎暏暐暑暒暓暔暕暖暗暘暙暚暛暜暝暞暟暠暡暢暣暤暥暦暧暨暩暪暫暬暭暮暯暰暱暲暳暴暵暶暷暸暹暺暻暼暽暾暿曀曁曂曃曄曅曆曇曈曉曊曋曌曍曎曏曐曑曒曓曔曕曖曗曘曙曚曛曜曝曞曟曠曡曢曣曤曥曦曧曨曩曪曫曬曭曮曯曰曱曲曳更曵曶曷書曹曺曻曼曽曾替最朁朂會朄朅朆朇月有朊朋朌服朎朏朐朑朒朓朔朕朖朗朘朙朚望朜朝朞期朠朡朢朣朤朥朦朧木朩未末本札朮术朰朱朲朳朴朵朶朷朸朹机朻朼朽朾朿杀杁杂权杄杅杆杇杈杉杊杋杌杍李杏材村杒杓杔杕杖杗杘杙杚杛杜杝杞束杠条杢杣杤来杦杧杨杩杪杫杬杭杮杯杰東杲杳杴杵杶杷杸杹杺杻杼杽松板枀极枂枃构枅枆枇枈枉枊枋枌枍枎枏析枑枒枓枔枕枖林枘枙枚枛果枝枞枟枠枡枢枣枤枥枦枧枨枩枪枫枬枭枮枯枰枱枲枳枴枵架枷枸枹枺枻枼枽枾枿柀柁柂柃柄柅柆柇柈柉柊柋柌柍柎柏某柑柒染柔柕柖柗柘柙柚柛柜柝柞柟柠柡柢柣柤查柦柧柨柩柪柫柬柭柮柯柰柱柲柳柴柵柶柷柸柹柺査柼柽柾柿栀栁栂栃栄栅栆标栈栉栊栋栌栍栎栏栐树栒栓栔栕栖栗栘栙栚栛栜栝栞栟栠校栢栣栤栥栦栧栨栩株栫栬栭栮栯栰栱栲栳栴栵栶样核根栺栻格栽栾栿桀桁桂桃桄桅框桇案桉桊桋桌桍桎桏桐桑桒桓桔桕桖桗桘桙桚桛桜桝桞桟桠桡桢档桤桥桦桧桨桩桪桫桬桭桮桯桰桱桲桳桴桵桶桷桸桹桺桻桼桽桾桿梀梁梂梃梄梅梆梇梈梉梊梋梌梍梎梏梐梑梒梓梔梕梖梗梘梙梚梛梜條梞梟梠梡梢梣梤梥梦梧梨梩梪梫梬梭梮梯械梱梲梳梴梵梶梷梸梹梺梻梼梽梾梿检棁棂棃棄棅棆棇棈棉棊棋棌棍棎棏棐棑棒棓棔棕棖棗棘棙棚棛棜棝棞棟棠棡棢棣棤棥棦棧棨棩棪棫棬棭森棯棰棱棲棳棴棵棶棷棸棹棺棻棼棽棾棿椀椁椂椃椄椅椆椇椈椉椊椋椌植椎椏椐椑椒椓椔椕椖椗椘椙椚椛検椝椞椟椠椡椢椣椤椥椦椧椨椩椪椫椬椭椮椯椰椱椲椳椴椵椶椷椸椹椺椻椼椽椾椿楀楁楂楃楄楅楆楇楈楉楊楋楌楍楎楏楐楑楒楓楔楕楖楗楘楙楚楛楜楝楞楟楠楡楢楣楤楥楦楧楨楩楪楫楬業楮楯楰楱楲楳楴極楶楷楸楹楺楻楼楽楾楿榀榁概榃榄榅榆榇榈榉榊榋榌榍榎榏榐榑榒榓榔榕榖榗榘榙榚榛榜榝榞榟榠榡榢榣榤榥榦榧榨榩榪榫榬榭榮榯榰榱榲榳榴榵榶榷榸榹榺榻榼榽榾榿槀槁槂槃槄槅槆槇槈槉槊構槌槍槎槏槐槑槒槓槔槕槖槗様槙槚槛槜槝槞槟槠槡槢槣槤槥槦槧槨槩槪槫槬槭槮槯槰槱槲槳槴槵槶槷槸槹槺槻槼槽槾槿樀樁樂樃樄樅樆樇樈樉樊樋樌樍樎樏樐樑樒樓樔樕樖樗樘標樚樛樜樝樞樟樠模樢樣樤樥樦樧樨権横樫樬樭樮樯樰樱樲樳樴樵樶樷樸樹樺樻樼樽樾樿橀橁橂橃橄橅橆橇橈橉橊橋橌橍橎橏橐橑橒橓橔橕橖橗橘橙橚橛橜橝橞機橠橡橢橣橤橥橦橧橨橩橪橫橬橭橮橯橰橱橲橳橴橵橶橷橸橹橺橻橼橽橾橿檀檁檂檃檄檅檆檇檈檉檊檋檌檍檎檏檐檑檒檓檔檕檖檗檘檙檚檛檜檝檞檟檠檡檢檣檤檥檦檧檨檩檪檫檬檭檮檯檰檱檲檳檴檵檶檷檸檹檺檻檼檽檾檿櫀櫁櫂櫃櫄櫅櫆櫇櫈櫉櫊櫋櫌櫍櫎櫏櫐櫑櫒櫓櫔櫕櫖櫗櫘櫙櫚櫛櫜櫝櫞櫟櫠櫡櫢櫣櫤櫥櫦櫧櫨櫩櫪櫫櫬櫭櫮櫯櫰櫱櫲櫳櫴櫵櫶櫷櫸櫹櫺櫻櫼櫽櫾櫿欀欁欂欃欄欅欆欇欈欉權欋欌欍欎欏欐欑欒欓欔欕欖欗欘欙欚欛欜欝欞欟欠次欢欣欤欥欦欧欨欩欪欫欬欭欮欯欰欱欲欳欴欵欶欷欸欹欺欻欼欽款欿歀歁歂歃歄歅歆歇歈歉歊歋歌歍歎歏歐歑歒歓歔歕歖歗歘歙歚歛歜歝歞歟歠歡止正此步武歧歨歩歪歫歬歭歮歯歰歱歲歳歴歵歶歷歸歹歺死歼歽歾歿殀殁殂殃殄殅殆殇殈殉殊残殌殍殎殏殐殑殒殓殔殕殖殗殘殙殚殛殜殝殞殟殠殡殢殣殤殥殦殧殨殩殪殫殬殭殮殯殰殱殲殳殴段殶殷殸殹殺殻殼殽殾殿毀毁毂毃毄毅毆毇毈毉毊毋毌母毎每毐毑毒毓比毕毖毗毘毙毚毛毜毝毞毟毠毡毢毣毤毥毦毧毨毩毪毫毬毭毮毯毰毱毲毳毴毵毶毷毸毹毺毻毼毽毾毿氀氁氂氃氄氅氆氇氈氉氊氋氌氍氎氏氐民氒氓气氕氖気氘氙氚氛氜氝氞氟氠氡氢氣氤氥氦氧氨氩氪氫氬氭氮氯氰氱氲氳水氵氶氷永氹氺氻氼氽氾氿汀汁求汃汄汅汆汇汈汉汊汋汌汍汎汏汐汑汒汓汔汕汖汗汘汙汚汛汜汝汞江池污汢汣汤汥汦汧汨汩汪汫汬汭汮汯汰汱汲汳汴汵汶汷汸汹決汻汼汽汾汿沀沁沂沃沄沅沆沇沈沉沊沋沌沍沎沏沐沑沒沓沔沕沖沗沘沙沚沛沜沝沞沟沠没沢沣沤沥沦沧沨沩沪沫沬沭沮沯沰沱沲河沴沵沶沷沸油沺治沼沽沾沿泀況泂泃泄泅泆泇泈泉泊泋泌泍泎泏泐泑泒泓泔法泖泗泘泙泚泛泜泝泞泟泠泡波泣泤泥泦泧注泩泪泫泬泭泮泯泰泱泲泳泴泵泶泷泸泹泺泻泼泽泾泿洀洁洂洃洄洅洆洇洈洉洊洋洌洍洎洏洐洑洒洓洔洕洖洗洘洙洚洛洜洝洞洟洠洡洢洣洤津洦洧洨洩洪洫洬洭洮洯洰洱洲洳洴洵洶洷洸洹洺活洼洽派洿浀流浂浃浄浅浆浇浈浉浊测浌浍济浏浐浑浒浓浔浕浖浗浘浙浚浛浜浝浞浟浠浡浢浣浤浥浦浧浨浩浪浫浬浭浮浯浰浱浲浳浴浵浶海浸浹浺浻浼浽浾浿涀涁涂涃涄涅涆涇消涉涊涋涌涍涎涏涐涑涒涓涔涕涖涗涘涙涚涛涜涝涞涟涠涡涢涣涤涥润涧涨涩涪涫涬涭涮涯涰涱液涳涴涵涶涷涸涹涺涻涼涽涾涿淀淁淂淃淄淅淆淇淈淉淊淋淌淍淎淏淐淑淒淓淔淕淖淗淘淙淚淛淜淝淞淟淠淡淢淣淤淥淦淧淨淩淪淫淬淭淮淯淰深淲淳淴淵淶混淸淹淺添淼淽淾淿渀渁渂渃渄清渆渇済渉渊渋渌渍渎渏渐渑渒渓渔渕渖渗渘渙渚減渜渝渞渟渠渡渢渣渤渥渦渧渨温渪渫測渭渮港渰渱渲渳渴渵渶渷游渹渺渻渼渽渾渿湀湁湂湃湄湅湆湇湈湉湊湋湌湍湎湏湐湑湒湓湔湕湖湗湘湙湚湛湜湝湞湟湠湡湢湣湤湥湦湧湨湩湪湫湬湭湮湯湰湱湲湳湴湵湶湷湸湹湺湻湼湽湾湿満溁溂溃溄溅溆溇溈溉溊溋溌溍溎溏源溑溒溓溔溕準溗溘溙溚溛溜溝溞溟溠溡溢溣溤溥溦溧溨溩溪溫溬溭溮溯溰溱溲溳溴溵溶溷溸溹溺溻溼溽溾溿滀滁滂滃滄滅滆滇滈滉滊滋滌滍滎滏滐滑滒滓滔滕滖滗滘滙滚滛滜滝滞滟滠满滢滣滤滥滦滧滨滩滪滫滬滭滮滯滰滱滲滳滴滵滶滷滸滹滺滻滼滽滾滿漀漁漂漃漄漅漆漇漈漉漊漋漌漍漎漏漐漑漒漓演漕漖漗漘漙漚漛漜漝漞漟漠漡漢漣漤漥漦漧漨漩漪漫漬漭漮漯漰漱漲漳漴漵漶漷漸漹漺漻漼漽漾漿潀潁潂潃潄潅潆潇潈潉潊潋潌潍潎潏潐潑潒潓潔潕潖潗潘潙潚潛潜潝潞潟潠潡潢潣潤潥潦潧潨潩潪潫潬潭潮潯潰潱潲潳潴潵潶潷潸潹潺潻潼潽潾潿澀澁澂澃澄澅澆澇澈澉澊澋澌澍澎澏澐澑澒澓澔澕澖澗澘澙澚澛澜澝澞澟澠澡澢澣澤澥澦澧澨澩澪澫澬澭澮澯澰澱澲澳澴澵澶澷澸澹澺澻澼澽澾澿激濁濂濃濄濅濆濇濈濉濊濋濌濍濎濏濐濑濒濓濔濕濖濗濘濙濚濛濜濝濞濟濠濡濢濣濤濥濦濧濨濩濪濫濬濭濮濯濰濱濲濳濴濵濶濷濸濹濺濻濼濽濾濿瀀瀁瀂瀃瀄瀅瀆瀇瀈瀉瀊瀋瀌瀍瀎瀏瀐瀑瀒瀓瀔瀕瀖瀗瀘瀙瀚瀛瀜瀝瀞瀟瀠瀡瀢瀣瀤瀥瀦瀧瀨瀩瀪瀫瀬瀭瀮瀯瀰瀱瀲瀳瀴瀵瀶瀷瀸瀹瀺瀻瀼瀽瀾瀿灀灁灂灃灄灅灆灇灈灉灊灋灌灍灎灏灐灑灒灓灔灕灖灗灘灙灚灛灜灝灞灟灠灡灢灣灤灥灦灧灨灩灪火灬灭灮灯灰灱灲灳灴灵灶灷灸灹灺灻灼災灾灿炀炁炂炃炄炅炆炇炈炉炊炋炌炍炎炏炐炑炒炓炔炕炖炗炘炙炚炛炜炝炞炟炠炡炢炣炤炥炦炧炨炩炪炫炬炭炮炯炰炱炲炳炴炵炶炷炸点為炻炼炽炾炿烀烁烂烃烄烅烆烇烈烉烊烋烌烍烎烏烐烑烒烓烔烕烖烗烘烙烚烛烜烝烞烟烠烡烢烣烤烥烦烧烨烩烪烫烬热烮烯烰烱烲烳烴烵烶烷烸烹烺烻烼烽烾烿焀焁焂焃焄焅焆焇焈焉焊焋焌焍焎焏焐焑焒焓焔焕焖焗焘焙焚焛焜焝焞焟焠無焢焣焤焥焦焧焨焩焪焫焬焭焮焯焰焱焲焳焴焵然焷焸焹焺焻焼焽焾焿煀煁煂煃煄煅煆煇煈煉煊煋煌煍煎煏煐煑煒煓煔煕煖煗煘煙煚煛煜煝煞煟煠煡煢煣煤煥煦照煨煩煪煫煬煭煮煯煰煱煲煳煴煵煶煷煸煹煺煻煼煽煾煿熀熁熂熃熄熅熆熇熈熉熊熋熌熍熎熏熐熑熒熓熔熕熖熗熘熙熚熛熜熝熞熟熠熡熢熣熤熥熦熧熨熩熪熫熬熭熮熯熰熱熲熳熴熵熶熷熸熹熺熻熼熽熾熿燀燁燂燃燄燅燆燇燈燉燊燋燌燍燎燏燐燑燒燓燔燕燖燗燘燙燚燛燜燝燞營燠燡燢燣燤燥燦燧燨燩燪燫燬燭燮燯燰燱燲燳燴燵燶燷燸燹燺燻燼燽燾燿爀爁爂爃爄爅爆爇爈爉爊爋爌爍爎爏爐爑爒爓爔爕爖爗爘爙爚爛爜爝爞爟爠爡爢爣爤爥爦爧爨爩爪爫爬爭爮爯爰爱爲爳爴爵父爷爸爹爺爻爼爽爾爿牀牁牂牃牄牅牆片版牉牊牋牌牍牎牏牐牑牒牓牔牕牖牗牘牙牚牛牜牝牞牟牠牡牢牣牤牥牦牧牨物牪牫牬牭牮牯牰牱牲牳牴牵牶牷牸特牺牻牼牽牾牿犀犁犂犃犄犅犆犇犈犉犊犋犌犍犎犏犐犑犒犓犔犕犖犗犘犙犚犛犜犝犞犟犠犡犢犣犤犥犦犧犨犩犪犫犬犭犮犯犰犱犲犳犴犵状犷犸犹犺犻犼犽犾犿狀狁狂狃狄狅狆狇狈狉狊狋狌狍狎狏狐狑狒狓狔狕狖狗狘狙狚狛狜狝狞狟狠狡狢狣狤狥狦狧狨狩狪狫独狭狮狯狰狱狲狳狴狵狶狷狸狹狺狻狼狽狾狿猀猁猂猃猄猅猆猇猈猉猊猋猌猍猎猏猐猑猒猓猔猕猖猗猘猙猚猛猜猝猞猟猠猡猢猣猤猥猦猧猨猩猪猫猬猭献猯猰猱猲猳猴猵猶猷猸猹猺猻猼猽猾猿獀獁獂獃獄獅獆獇獈獉獊獋獌獍獎獏獐獑獒獓獔獕獖獗獘獙獚獛獜獝獞獟獠獡獢獣獤獥獦獧獨獩獪獫獬獭獮獯獰獱獲獳獴獵獶獷獸獹獺獻獼獽獾獿玀玁玂玃玄玅玆率玈玉玊王玌玍玎玏玐玑玒玓玔玕玖玗玘玙玚玛玜玝玞玟玠玡玢玣玤玥玦玧玨玩玪玫玬玭玮环现玱玲玳玴玵玶玷玸玹玺玻玼玽玾玿珀珁珂珃珄珅珆珇珈珉珊珋珌珍珎珏珐珑珒珓珔珕珖珗珘珙珚珛珜珝珞珟珠珡珢珣珤珥珦珧珨珩珪珫珬班珮珯珰珱珲珳珴珵珶珷珸珹珺珻珼珽現珿琀琁琂球琄琅理琇琈琉琊琋琌琍琎琏琐琑琒琓琔琕琖琗琘琙琚琛琜琝琞琟琠琡琢琣琤琥琦琧琨琩琪琫琬琭琮琯琰琱琲琳琴琵琶琷琸琹琺琻琼琽琾琿瑀瑁瑂瑃瑄瑅瑆瑇瑈瑉瑊瑋瑌瑍瑎瑏瑐瑑瑒瑓瑔瑕瑖瑗瑘瑙瑚瑛瑜瑝瑞瑟瑠瑡瑢瑣瑤瑥瑦瑧瑨瑩瑪瑫瑬瑭瑮瑯瑰瑱瑲瑳瑴瑵瑶瑷瑸瑹瑺瑻瑼瑽瑾瑿璀璁璂璃璄璅璆璇璈璉璊璋璌璍璎璏璐璑璒璓璔璕璖璗璘璙璚璛璜璝璞璟璠璡璢璣璤璥璦璧璨璩璪璫璬璭璮璯環璱璲璳璴璵璶璷璸璹璺璻璼璽璾璿瓀瓁瓂瓃瓄瓅瓆瓇瓈瓉瓊瓋瓌瓍瓎瓏瓐瓑瓒瓓瓔瓕瓖瓗瓘瓙瓚瓛瓜瓝瓞瓟瓠瓡瓢瓣瓤瓥瓦瓧瓨瓩瓪瓫瓬瓭瓮瓯瓰瓱瓲瓳瓴瓵瓶瓷瓸瓹瓺瓻瓼瓽瓾瓿甀甁甂甃甄甅甆甇甈甉甊甋甌甍甎甏甐甑甒甓甔甕甖甗甘甙甚甛甜甝甞生甠甡產産甤甥甦甧用甩甪甫甬甭甮甯田由甲申甴电甶男甸甹町画甼甽甾甿畀畁畂畃畄畅畆畇畈畉畊畋界畍畎畏畐畑畒畓畔畕畖畗畘留畚畛畜畝畞畟畠畡畢畣畤略畦畧畨畩番畫畬畭畮畯異畱畲畳畴畵當畷畸畹畺畻畼畽畾畿疀疁疂疃疄疅疆疇疈疉疊疋疌疍疎疏疐疑疒疓疔疕疖疗疘疙疚疛疜疝疞疟疠疡疢疣疤疥疦疧疨疩疪疫疬疭疮疯疰疱疲疳疴疵疶疷疸疹疺疻疼疽疾疿痀痁痂痃痄病痆症痈痉痊痋痌痍痎痏痐痑痒痓痔痕痖痗痘痙痚痛痜痝痞痟痠痡痢痣痤痥痦痧痨痩痪痫痬痭痮痯痰痱痲痳痴痵痶痷痸痹痺痻痼痽痾痿瘀瘁瘂瘃瘄瘅瘆瘇瘈瘉瘊瘋瘌瘍瘎瘏瘐瘑瘒瘓瘔瘕瘖瘗瘘瘙瘚瘛瘜瘝瘞瘟瘠瘡瘢瘣瘤瘥瘦瘧瘨瘩瘪瘫瘬瘭瘮瘯瘰瘱瘲瘳瘴瘵瘶瘷瘸瘹瘺瘻瘼瘽瘾瘿癀癁療癃癄癅癆癇癈癉癊癋癌癍癎癏癐癑癒癓癔癕癖癗癘癙癚癛癜癝癞癟癠癡癢癣癤癥癦癧癨癩癪癫癬癭癮癯癰癱癲癳癴癵癶癷癸癹発登發白百癿皀皁皂皃的皅皆皇皈皉皊皋皌皍皎皏皐皑皒皓皔皕皖皗皘皙皚皛皜皝皞皟皠皡皢皣皤皥皦皧皨皩皪皫皬皭皮皯皰皱皲皳皴皵皶皷皸皹皺皻皼皽皾皿盀盁盂盃盄盅盆盇盈盉益盋盌盍盎盏盐监盒盓盔盕盖盗盘盙盚盛盜盝盞盟盠盡盢監盤盥盦盧盨盩盪盫盬盭目盯盰盱盲盳直盵盶盷相盹盺盻盼盽盾盿眀省眂眃眄眅眆眇眈眉眊看県眍眎眏眐眑眒眓眔眕眖眗眘眙眚眛眜眝眞真眠眡眢眣眤眥眦眧眨眩眪眫眬眭眮眯眰眱眲眳眴眵眶眷眸眹眺眻眼眽眾眿着睁睂睃睄睅睆睇睈睉睊睋睌睍睎睏睐睑睒睓睔睕睖睗睘睙睚睛睜睝睞睟睠睡睢督睤睥睦睧睨睩睪睫睬睭睮睯睰睱睲睳睴睵睶睷睸睹睺睻睼睽睾睿瞀瞁瞂瞃瞄瞅瞆瞇瞈瞉瞊瞋瞌瞍瞎瞏瞐瞑瞒瞓瞔瞕瞖瞗瞘瞙瞚瞛瞜瞝瞞瞟瞠瞡瞢瞣瞤瞥瞦瞧瞨瞩瞪瞫瞬瞭瞮瞯瞰瞱瞲瞳瞴瞵瞶瞷瞸瞹瞺瞻瞼瞽瞾瞿矀矁矂矃矄矅矆矇矈矉矊矋矌矍矎矏矐矑矒矓矔矕矖矗矘矙矚矛矜矝矞矟矠矡矢矣矤知矦矧矨矩矪矫矬短矮矯矰矱矲石矴矵矶矷矸矹矺矻矼矽矾矿砀码砂砃砄砅砆砇砈砉砊砋砌砍砎砏砐砑砒砓研砕砖砗砘砙砚砛砜砝砞砟砠砡砢砣砤砥砦砧砨砩砪砫砬砭砮砯砰砱砲砳破砵砶砷砸砹砺砻砼砽砾砿础硁硂硃硄硅硆硇硈硉硊硋硌硍硎硏硐硑硒硓硔硕硖硗硘硙硚硛硜硝硞硟硠硡硢硣硤硥硦硧硨硩硪硫硬硭确硯硰硱硲硳硴硵硶硷硸硹硺硻硼硽硾硿碀碁碂碃碄碅碆碇碈碉碊碋碌碍碎碏碐碑碒碓碔碕碖碗碘碙碚碛碜碝碞碟碠碡碢碣碤碥碦碧碨碩碪碫碬碭碮碯碰碱碲碳碴碵碶碷碸碹確碻碼碽碾碿磀磁磂磃磄磅磆磇磈磉磊磋磌磍磎磏磐磑磒磓磔磕磖磗磘磙磚磛磜磝磞磟磠磡磢磣磤磥磦磧磨磩磪磫磬磭磮磯磰磱磲磳磴磵磶磷磸磹磺磻磼磽磾磿礀礁礂礃礄礅礆礇礈礉礊礋礌礍礎礏礐礑礒礓礔礕礖礗礘礙礚礛礜礝礞礟礠礡礢礣礤礥礦礧礨礩礪礫礬礭礮礯礰礱礲礳礴礵礶礷礸礹示礻礼礽社礿祀祁祂祃祄祅祆祇祈祉祊祋祌祍祎祏祐祑祒祓祔祕祖祗祘祙祚祛祜祝神祟祠祡祢祣祤祥祦祧票祩祪祫祬祭祮祯祰祱祲祳祴祵祶祷祸祹祺祻祼祽祾祿禀禁禂禃禄禅禆禇禈禉禊禋禌禍禎福禐禑禒禓禔禕禖禗禘禙禚禛禜禝禞禟禠禡禢禣禤禥禦禧禨禩禪禫禬禭禮禯禰禱禲禳禴禵禶禷禸禹禺离禼禽禾禿秀私秂秃秄秅秆秇秈秉秊秋秌种秎秏秐科秒秓秔秕秖秗秘秙秚秛秜秝秞租秠秡秢秣秤秥秦秧秨秩秪秫秬秭秮积称秱秲秳秴秵秶秷秸秹秺移秼秽秾秿稀稁稂稃稄稅稆稇稈稉稊程稌稍税稏稐稑稒稓稔稕稖稗稘稙稚稛稜稝稞稟稠稡稢稣稤稥稦稧稨稩稪稫稬稭種稯稰稱稲稳稴稵稶稷稸稹稺稻稼稽稾稿穀穁穂穃穄穅穆穇穈穉穊穋穌積穎穏穐穑穒穓穔穕穖穗穘穙穚穛穜穝穞穟穠穡穢穣穤穥穦穧穨穩穪穫穬穭穮穯穰穱穲穳穴穵究穷穸穹空穻穼穽穾穿窀突窂窃窄窅窆窇窈窉窊窋窌窍窎窏窐窑窒窓窔窕窖窗窘窙窚窛窜窝窞窟窠窡窢窣窤窥窦窧窨窩窪窫窬窭窮窯窰窱窲窳窴窵窶窷窸窹窺窻窼窽窾窿竀竁竂竃竄竅竆竇竈竉竊立竌竍竎竏竐竑竒竓竔竕竖竗竘站竚竛竜竝竞竟章竡竢竣竤童竦竧竨竩竪竫竬竭竮端竰竱竲竳竴竵競竷竸竹竺竻竼竽竾竿笀笁笂笃笄笅笆笇笈笉笊笋笌笍笎笏笐笑笒笓笔笕笖笗笘笙笚笛笜笝笞笟笠笡笢笣笤笥符笧笨笩笪笫第笭笮笯笰笱笲笳笴笵笶笷笸笹笺笻笼笽笾笿筀筁筂筃筄筅筆筇筈等筊筋筌筍筎筏筐筑筒筓答筕策筗筘筙筚筛筜筝筞筟筠筡筢筣筤筥筦筧筨筩筪筫筬筭筮筯筰筱筲筳筴筵筶筷筸筹筺筻筼筽签筿简箁箂箃箄箅箆箇箈箉箊箋箌箍箎箏箐箑箒箓箔箕箖算箘箙箚箛箜箝箞箟箠管箢箣箤箥箦箧箨箩箪箫箬箭箮箯箰箱箲箳箴箵箶箷箸箹箺箻箼箽箾箿節篁篂篃範篅篆篇篈築篊篋篌篍篎篏篐篑篒篓篔篕篖篗篘篙篚篛篜篝篞篟篠篡篢篣篤篥篦篧篨篩篪篫篬篭篮篯篰篱篲篳篴篵篶篷篸篹篺篻篼篽篾篿簀簁簂簃簄簅簆簇簈簉簊簋簌簍簎簏簐簑簒簓簔簕簖簗簘簙簚簛簜簝簞簟簠簡簢簣簤簥簦簧簨簩簪簫簬簭簮簯簰簱簲簳簴簵簶簷簸簹簺簻簼簽簾簿籀籁籂籃籄籅籆籇籈籉籊籋籌籍籎籏籐籑籒籓籔籕籖籗籘籙籚籛籜籝籞籟籠籡籢籣籤籥籦籧籨籩籪籫籬籭籮籯籰籱籲米籴籵籶籷籸籹籺类籼籽籾籿粀粁粂粃粄粅粆粇粈粉粊粋粌粍粎粏粐粑粒粓粔粕粖粗粘粙粚粛粜粝粞粟粠粡粢粣粤粥粦粧粨粩粪粫粬粭粮粯粰粱粲粳粴粵粶粷粸粹粺粻粼粽精粿糀糁糂糃糄糅糆糇糈糉糊糋糌糍糎糏糐糑糒糓糔糕糖糗糘糙糚糛糜糝糞糟糠糡糢糣糤糥糦糧糨糩糪糫糬糭糮糯糰糱糲糳糴糵糶糷糸糹糺系糼糽糾糿紀紁紂紃約紅紆紇紈紉紊紋紌納紎紏紐紑紒紓純紕紖紗紘紙級紛紜紝紞紟素紡索紣紤紥紦紧紨紩紪紫紬紭紮累細紱紲紳紴紵紶紷紸紹紺紻紼紽紾紿絀絁終絃組絅絆絇絈絉絊絋経絍絎絏結絑絒絓絔絕絖絗絘絙絚絛絜絝絞絟絠絡絢絣絤絥給絧絨絩絪絫絬絭絮絯絰統絲絳絴絵絶絷絸絹絺絻絼絽絾絿綀綁綂綃綄綅綆綇綈綉綊綋綌綍綎綏綐綑綒經綔綕綖綗綘継続綛綜綝綞綟綠綡綢綣綤綥綦綧綨綩綪綫綬維綮綯綰綱網綳綴綵綶綷綸綹綺綻綼綽綾綿緀緁緂緃緄緅緆緇緈緉緊緋緌緍緎総緐緑緒緓緔緕緖緗緘緙線緛緜緝緞緟締緡緢緣緤緥緦緧編緩緪緫緬緭緮緯緰緱緲緳練緵緶緷緸緹緺緻緼緽緾緿縀縁縂縃縄縅縆縇縈縉縊縋縌縍縎縏縐縑縒縓縔縕縖縗縘縙縚縛縜縝縞縟縠縡縢縣縤縥縦縧縨縩縪縫縬縭縮縯縰縱縲縳縴縵縶縷縸縹縺縻縼總績縿繀繁繂繃繄繅繆繇繈繉繊繋繌繍繎繏繐繑繒繓織繕繖繗繘繙繚繛繜繝繞繟繠繡繢繣繤繥繦繧繨繩繪繫繬繭繮繯繰繱繲繳繴繵繶繷繸繹繺繻繼繽繾繿纀纁纂纃纄纅纆纇纈纉纊纋續纍纎纏纐纑纒纓纔纕纖纗纘纙纚纛纜纝纞纟纠纡红纣纤纥约级纨纩纪纫纬纭纮纯纰纱纲纳纴纵纶纷纸纹纺纻纼纽纾线绀绁绂练组绅细织终绉绊绋绌绍绎经绐绑绒结绔绕绖绗绘给绚绛络绝绞统绠绡绢绣绤绥绦继绨绩绪绫绬续绮绯绰绱绲绳维绵绶绷绸绹绺绻综绽绾绿缀缁缂缃缄缅缆缇缈缉缊缋缌缍缎缏缐缑缒缓缔缕编缗缘缙缚缛缜缝缞缟缠缡缢缣缤缥缦缧缨缩缪缫缬缭缮缯缰缱缲缳缴缵缶缷缸缹缺缻缼缽缾缿罀罁罂罃罄罅罆罇罈罉罊罋罌罍罎罏罐网罒罓罔罕罖罗罘罙罚罛罜罝罞罟罠罡罢罣罤罥罦罧罨罩罪罫罬罭置罯罰罱署罳罴罵罶罷罸罹罺罻罼罽罾罿羀羁羂羃羄羅羆羇羈羉羊羋羌羍美羏羐羑羒羓羔羕羖羗羘羙羚羛羜羝羞羟羠羡羢羣群羥羦羧羨義羪羫羬羭羮羯羰羱羲羳羴羵羶羷羸羹羺羻羼羽羾羿翀翁翂翃翄翅翆翇翈翉翊翋翌翍翎翏翐翑習翓翔翕翖翗翘翙翚翛翜翝翞翟翠翡翢翣翤翥翦翧翨翩翪翫翬翭翮翯翰翱翲翳翴翵翶翷翸翹翺翻翼翽翾翿耀老耂考耄者耆耇耈耉耊耋而耍耎耏耐耑耒耓耔耕耖耗耘耙耚耛耜耝耞耟耠耡耢耣耤耥耦耧耨耩耪耫耬耭耮耯耰耱耲耳耴耵耶耷耸耹耺耻耼耽耾耿聀聁聂聃聄聅聆聇聈聉聊聋职聍聎聏聐聑聒聓联聕聖聗聘聙聚聛聜聝聞聟聠聡聢聣聤聥聦聧聨聩聪聫聬聭聮聯聰聱聲聳聴聵聶職聸聹聺聻聼聽聾聿肀肁肂肃肄肅肆肇肈肉肊肋肌肍肎肏肐肑肒肓肔肕肖肗肘肙肚肛肜肝肞肟肠股肢肣肤肥肦肧肨肩肪肫肬肭肮肯肰肱育肳肴肵肶肷肸肹肺肻肼肽肾肿胀胁胂胃胄胅胆胇胈胉胊胋背胍胎胏胐胑胒胓胔胕胖胗胘胙胚胛胜胝胞胟胠胡胢胣胤胥胦胧胨胩胪胫胬胭胮胯胰胱胲胳胴胵胶胷胸胹胺胻胼能胾胿脀脁脂脃脄脅脆脇脈脉脊脋脌脍脎脏脐脑脒脓脔脕脖脗脘脙脚脛脜脝脞脟脠脡脢脣脤脥脦脧脨脩脪脫脬脭脮脯脰脱脲脳脴脵脶脷脸脹脺脻脼脽脾脿腀腁腂腃腄腅腆腇腈腉腊腋腌腍腎腏腐腑腒腓腔腕腖腗腘腙腚腛腜腝腞腟腠腡腢腣腤腥腦腧腨腩腪腫腬腭腮腯腰腱腲腳腴腵腶腷腸腹腺腻腼腽腾腿膀膁膂膃膄膅膆膇膈膉膊膋膌膍膎膏膐膑膒膓膔膕膖膗膘膙膚膛膜膝膞膟膠膡膢膣膤膥膦膧膨膩膪膫膬膭膮膯膰膱膲膳膴膵膶膷膸膹膺膻膼膽膾膿臀臁臂臃臄臅臆臇臈臉臊臋臌臍臎臏臐臑臒臓臔臕臖臗臘臙臚臛臜臝臞臟臠臡臢臣臤臥臦臧臨臩自臫臬臭臮臯臰臱臲至致臵臶臷臸臹臺臻臼臽臾臿舀舁舂舃舄舅舆與興舉舊舋舌舍舎舏舐舑舒舓舔舕舖舗舘舙舚舛舜舝舞舟舠舡舢舣舤舥舦舧舨舩航舫般舭舮舯舰舱舲舳舴舵舶舷舸船舺舻舼舽舾舿艀艁艂艃艄艅艆艇艈艉艊艋艌艍艎艏艐艑艒艓艔艕艖艗艘艙艚艛艜艝艞艟艠艡艢艣艤艥艦艧艨艩艪艫艬艭艮良艰艱色艳艴艵艶艷艸艹艺艻艼艽艾艿芀芁节芃芄芅芆芇芈芉芊芋芌芍芎芏芐芑芒芓芔芕芖芗芘芙芚芛芜芝芞芟芠芡芢芣芤芥芦芧芨芩芪芫芬芭芮芯芰花芲芳芴芵芶芷芸芹芺芻芼芽芾芿苀苁苂苃苄苅苆苇苈苉苊苋苌苍苎苏苐苑苒苓苔苕苖苗苘苙苚苛苜苝苞苟苠苡苢苣苤若苦苧苨苩苪苫苬苭苮苯苰英苲苳苴苵苶苷苸苹苺苻苼苽苾苿茀茁茂范茄茅茆茇茈茉茊茋茌茍茎茏茐茑茒茓茔茕茖茗茘茙茚茛茜茝茞茟茠茡茢茣茤茥茦茧茨茩茪茫茬茭茮茯茰茱茲茳茴茵茶茷茸茹茺茻茼茽茾茿荀荁荂荃荄荅荆荇荈草荊荋荌荍荎荏荐荑荒荓荔荕荖荗荘荙荚荛荜荝荞荟荠荡荢荣荤荥荦荧荨荩荪荫荬荭荮药荰荱荲荳荴荵荶荷荸荹荺荻荼荽荾荿莀莁莂莃莄莅莆莇莈莉莊莋莌莍莎莏莐莑莒莓莔莕莖莗莘莙莚莛莜莝莞莟莠莡莢莣莤莥莦莧莨莩莪莫莬莭莮莯莰莱莲莳莴莵莶获莸莹莺莻莼莽莾莿菀菁菂菃菄菅菆菇菈菉菊菋菌菍菎菏菐菑菒菓菔菕菖菗菘菙菚菛菜菝菞菟菠菡菢菣菤菥菦菧菨菩菪菫菬菭菮華菰菱菲菳菴菵菶菷菸菹菺菻菼菽菾菿萀萁萂萃萄萅萆萇萈萉萊萋萌萍萎萏萐萑萒萓萔萕萖萗萘萙萚萛萜萝萞萟萠萡萢萣萤营萦萧萨萩萪萫萬萭萮萯萰萱萲萳萴萵萶萷萸萹萺萻萼落萾萿葀葁葂葃葄葅葆葇葈葉葊葋葌葍葎葏葐葑葒葓葔葕葖著葘葙葚葛葜葝葞葟葠葡葢董葤葥葦葧葨葩葪葫葬葭葮葯葰葱葲葳葴葵葶葷葸葹葺葻葼葽葾葿蒀蒁蒂蒃蒄蒅蒆蒇蒈蒉蒊蒋蒌蒍蒎蒏蒐蒑蒒蒓蒔蒕蒖蒗蒘蒙蒚蒛蒜蒝蒞蒟蒠蒡蒢蒣蒤蒥蒦蒧蒨蒩蒪蒫蒬蒭蒮蒯蒰蒱蒲蒳蒴蒵蒶蒷蒸蒹蒺蒻蒼蒽蒾蒿蓀蓁蓂蓃蓄蓅蓆蓇蓈蓉蓊蓋蓌蓍蓎蓏蓐蓑蓒蓓蓔蓕蓖蓗蓘蓙蓚蓛蓜蓝蓞蓟蓠蓡蓢蓣蓤蓥蓦蓧蓨蓩蓪蓫蓬蓭蓮蓯蓰蓱蓲蓳蓴蓵蓶蓷蓸蓹蓺蓻蓼蓽蓾蓿蔀蔁蔂蔃蔄蔅蔆蔇蔈蔉蔊蔋蔌蔍蔎蔏蔐蔑蔒蔓蔔蔕蔖蔗蔘蔙蔚蔛蔜蔝蔞蔟蔠蔡蔢蔣蔤蔥蔦蔧蔨蔩蔪蔫蔬蔭蔮蔯蔰蔱蔲蔳蔴蔵蔶蔷蔸蔹蔺蔻蔼蔽蔾蔿蕀蕁蕂蕃蕄蕅蕆蕇蕈蕉蕊蕋蕌蕍蕎蕏蕐蕑蕒蕓蕔蕕蕖蕗蕘蕙蕚蕛蕜蕝蕞蕟蕠蕡蕢蕣蕤蕥蕦蕧蕨蕩蕪蕫蕬蕭蕮蕯蕰蕱蕲蕳蕴蕵蕶蕷蕸蕹蕺蕻蕼蕽蕾蕿薀薁薂薃薄薅薆薇薈薉薊薋薌薍薎薏薐薑薒薓薔薕薖薗薘薙薚薛薜薝薞薟薠薡薢薣薤薥薦薧薨薩薪薫薬薭薮薯薰薱薲薳薴薵薶薷薸薹薺薻薼薽薾薿藀藁藂藃藄藅藆藇藈藉藊藋藌藍藎藏藐藑藒藓藔藕藖藗藘藙藚藛藜藝藞藟藠藡藢藣藤藥藦藧藨藩藪藫藬藭藮藯藰藱藲藳藴藵藶藷藸藹藺藻藼藽藾藿蘀蘁蘂蘃蘄蘅蘆蘇蘈蘉蘊蘋蘌蘍蘎蘏蘐蘑蘒蘓蘔蘕蘖蘗蘘蘙蘚蘛蘜蘝蘞蘟蘠蘡蘢蘣蘤蘥蘦蘧蘨蘩蘪蘫蘬蘭蘮蘯蘰蘱蘲蘳蘴蘵蘶蘷蘸蘹蘺蘻蘼蘽蘾蘿虀虁虂虃虄虅虆虇虈虉虊虋虌虍虎虏虐虑虒虓虔處虖虗虘虙虚虛虜虝虞號虠虡虢虣虤虥虦虧虨虩虪虫虬虭虮虯虰虱虲虳虴虵虶虷虸虹虺虻虼虽虾虿蚀蚁蚂蚃蚄蚅蚆蚇蚈蚉蚊蚋蚌蚍蚎蚏蚐蚑蚒蚓蚔蚕蚖蚗蚘蚙蚚蚛蚜蚝蚞蚟蚠蚡蚢蚣蚤蚥蚦蚧蚨蚩蚪蚫蚬蚭蚮蚯蚰蚱蚲蚳蚴蚵蚶蚷蚸蚹蚺蚻蚼蚽蚾蚿蛀蛁蛂蛃蛄蛅蛆蛇蛈蛉蛊蛋蛌蛍蛎蛏蛐蛑蛒蛓蛔蛕蛖蛗蛘蛙蛚蛛蛜蛝蛞蛟蛠蛡蛢蛣蛤蛥蛦蛧蛨蛩蛪蛫蛬蛭蛮蛯蛰蛱蛲蛳蛴蛵蛶蛷蛸蛹蛺蛻蛼蛽蛾蛿蜀蜁蜂蜃蜄蜅蜆蜇蜈蜉蜊蜋蜌蜍蜎蜏蜐蜑蜒蜓蜔蜕蜖蜗蜘蜙蜚蜛蜜蜝蜞蜟蜠蜡蜢蜣蜤蜥蜦蜧蜨蜩蜪蜫蜬蜭蜮蜯蜰蜱蜲蜳蜴蜵蜶蜷蜸蜹蜺蜻蜼蜽蜾蜿蝀蝁蝂蝃蝄蝅蝆蝇蝈蝉蝊蝋蝌蝍蝎蝏蝐蝑蝒蝓蝔蝕蝖蝗蝘蝙蝚蝛蝜蝝蝞蝟蝠蝡蝢蝣蝤蝥蝦蝧蝨蝩蝪蝫蝬蝭蝮蝯蝰蝱蝲蝳蝴蝵蝶蝷蝸蝹蝺蝻蝼蝽蝾蝿螀螁螂螃螄螅螆螇螈螉螊螋螌融螎螏螐螑螒螓螔螕螖螗螘螙螚螛螜螝螞螟螠螡螢螣螤螥螦螧螨螩螪螫螬螭螮螯螰螱螲螳螴螵螶螷螸螹螺螻螼螽螾螿蟀蟁蟂蟃蟄蟅蟆蟇蟈蟉蟊蟋蟌蟍蟎蟏蟐蟑蟒蟓蟔蟕蟖蟗蟘蟙蟚蟛蟜蟝蟞蟟蟠蟡蟢蟣蟤蟥蟦蟧蟨蟩蟪蟫蟬蟭蟮蟯蟰蟱蟲蟳蟴蟵蟶蟷蟸蟹蟺蟻蟼蟽蟾蟿蠀蠁蠂蠃蠄蠅蠆蠇蠈蠉蠊蠋蠌蠍蠎蠏蠐蠑蠒蠓蠔蠕蠖蠗蠘蠙蠚蠛蠜蠝蠞蠟蠠蠡蠢蠣蠤蠥蠦蠧蠨蠩蠪蠫蠬蠭蠮蠯蠰蠱蠲蠳蠴蠵蠶蠷蠸蠹蠺蠻蠼蠽蠾蠿血衁衂衃衄衅衆衇衈衉衊衋行衍衎衏衐衑衒術衔衕衖街衘衙衚衛衜衝衞衟衠衡衢衣衤补衦衧表衩衪衫衬衭衮衯衰衱衲衳衴衵衶衷衸衹衺衻衼衽衾衿袀袁袂袃袄袅袆袇袈袉袊袋袌袍袎袏袐袑袒袓袔袕袖袗袘袙袚袛袜袝袞袟袠袡袢袣袤袥袦袧袨袩袪被袬袭袮袯袰袱袲袳袴袵袶袷袸袹袺袻袼袽袾袿裀裁裂裃裄装裆裇裈裉裊裋裌裍裎裏裐裑裒裓裔裕裖裗裘裙裚裛補裝裞裟裠裡裢裣裤裥裦裧裨裩裪裫裬裭裮裯裰裱裲裳裴裵裶裷裸裹裺裻裼製裾裿褀褁褂褃褄褅褆複褈褉褊褋褌褍褎褏褐褑褒褓褔褕褖褗褘褙褚褛褜褝褞褟褠褡褢褣褤褥褦褧褨褩褪褫褬褭褮褯褰褱褲褳褴褵褶褷褸褹褺褻褼褽褾褿襀襁襂襃襄襅襆襇襈襉襊襋襌襍襎襏襐襑襒襓襔襕襖襗襘襙襚襛襜襝襞襟襠襡襢襣襤襥襦襧襨襩襪襫襬襭襮襯襰襱襲襳襴襵襶襷襸襹襺襻襼襽襾西覀要覂覃覄覅覆覇覈覉覊見覌覍覎規覐覑覒覓覔覕視覗覘覙覚覛覜覝覞覟覠覡覢覣覤覥覦覧覨覩親覫覬覭覮覯覰覱覲観覴覵覶覷覸覹覺覻覼覽覾覿觀见观觃规觅视觇览觉觊觋觌觍觎觏觐觑角觓觔觕觖觗觘觙觚觛觜觝觞觟觠觡觢解觤觥触觧觨觩觪觫觬觭觮觯觰觱觲觳觴觵觶觷觸觹觺觻觼觽觾觿言訁訂訃訄訅訆訇計訉訊訋訌訍討訏訐訑訒訓訔訕訖託記訙訚訛訜訝訞訟訠訡訢訣訤訥訦訧訨訩訪訫訬設訮訯訰許訲訳訴訵訶訷訸訹診註証訽訾訿詀詁詂詃詄詅詆詇詈詉詊詋詌詍詎詏詐詑詒詓詔評詖詗詘詙詚詛詜詝詞詟詠詡詢詣詤詥試詧詨詩詪詫詬詭詮詯詰話該詳詴詵詶詷詸詹詺詻詼詽詾詿誀誁誂誃誄誅誆誇誈誉誊誋誌認誎誏誐誑誒誓誔誕誖誗誘誙誚誛誜誝語誟誠誡誢誣誤誥誦誧誨誩說誫説読誮誯誰誱課誳誴誵誶誷誸誹誺誻誼誽誾調諀諁諂諃諄諅諆談諈諉諊請諌諍諎諏諐諑諒諓諔諕論諗諘諙諚諛諜諝諞諟諠諡諢諣諤諥諦諧諨諩諪諫諬諭諮諯諰諱諲諳諴諵諶諷諸諹諺諻諼諽諾諿謀謁謂謃謄謅謆謇謈謉謊謋謌謍謎謏謐謑謒謓謔謕謖謗謘謙謚講謜謝謞謟謠謡謢謣謤謥謦謧謨謩謪謫謬謭謮謯謰謱謲謳謴謵謶謷謸謹謺謻謼謽謾謿譀譁譂譃譄譅譆譇譈證譊譋譌譍譎譏譐譑譒譓譔譕譖譗識譙譚譛譜譝譞譟譠譡譢譣譤譥警譧譨譩譪譫譬譭譮譯議譱譲譳譴譵譶護譸譹譺譻譼譽譾譿讀讁讂讃讄讅讆讇讈讉變讋讌讍讎讏讐讑讒讓讔讕讖讗讘讙讚讛讜讝讞讟讠计订讣认讥讦讧讨让讪讫讬训议讯记讱讲讳讴讵讶讷许讹论讻讼讽设访诀证诂诃评诅识诇诈诉诊诋诌词诎诏诐译诒诓诔试诖诗诘诙诚诛诜话诞诟诠诡询诣诤该详诧诨诩诪诫诬语诮误诰诱诲诳说诵诶请诸诹诺读诼诽课诿谀谁谂调谄谅谆谇谈谉谊谋谌谍谎谏谐谑谒谓谔谕谖谗谘谙谚谛谜谝谞谟谠谡谢谣谤谥谦谧谨谩谪谫谬谭谮谯谰谱谲谳谴谵谶谷谸谹谺谻谼谽谾谿豀豁豂豃豄豅豆豇豈豉豊豋豌豍豎豏豐豑豒豓豔豕豖豗豘豙豚豛豜豝豞豟豠象豢豣豤豥豦豧豨豩豪豫豬豭豮豯豰豱豲豳豴豵豶豷豸豹豺豻豼豽豾豿貀貁貂貃貄貅貆貇貈貉貊貋貌貍貎貏貐貑貒貓貔貕貖貗貘貙貚貛貜貝貞貟負財貢貣貤貥貦貧貨販貪貫責貭貮貯貰貱貲貳貴貵貶買貸貹貺費貼貽貾貿賀賁賂賃賄賅賆資賈賉賊賋賌賍賎賏賐賑賒賓賔賕賖賗賘賙賚賛賜賝賞賟賠賡賢賣賤賥賦賧賨賩質賫賬賭賮賯賰賱賲賳賴賵賶賷賸賹賺賻購賽賾賿贀贁贂贃贄贅贆贇贈贉贊贋贌贍贎贏贐贑贒贓贔贕贖贗贘贙贚贛贜贝贞负贠贡财责贤败账货质贩贪贫贬购贮贯贰贱贲贳贴贵贶贷贸费贺贻贼贽贾贿赀赁赂赃资赅赆赇赈赉赊赋赌赍赎赏赐赑赒赓赔赕赖赗赘赙赚赛赜赝赞赟赠赡赢赣赤赥赦赧赨赩赪赫赬赭赮赯走赱赲赳赴赵赶起赸赹赺赻赼赽赾赿趀趁趂趃趄超趆趇趈趉越趋趌趍趎趏趐趑趒趓趔趕趖趗趘趙趚趛趜趝趞趟趠趡趢趣趤趥趦趧趨趩趪趫趬趭趮趯趰趱趲足趴趵趶趷趸趹趺趻趼趽趾趿跀跁跂跃跄跅跆跇跈跉跊跋跌跍跎跏跐跑跒跓跔跕跖跗跘跙跚跛跜距跞跟跠跡跢跣跤跥跦跧跨跩跪跫跬跭跮路跰跱跲跳跴践跶跷跸跹跺跻跼跽跾跿踀踁踂踃踄踅踆踇踈踉踊踋踌踍踎踏踐踑踒踓踔踕踖踗踘踙踚踛踜踝踞踟踠踡踢踣踤踥踦踧踨踩踪踫踬踭踮踯踰踱踲踳踴踵踶踷踸踹踺踻踼踽踾踿蹀蹁蹂蹃蹄蹅蹆蹇蹈蹉蹊蹋蹌蹍蹎蹏蹐蹑蹒蹓蹔蹕蹖蹗蹘蹙蹚蹛蹜蹝蹞蹟蹠蹡蹢蹣蹤蹥蹦蹧蹨蹩蹪蹫蹬蹭蹮蹯蹰蹱蹲蹳蹴蹵蹶蹷蹸蹹蹺蹻蹼蹽蹾蹿躀躁躂躃躄躅躆躇躈躉躊躋躌躍躎躏躐躑躒躓躔躕躖躗躘躙躚躛躜躝躞躟躠躡躢躣躤躥躦躧躨躩躪身躬躭躮躯躰躱躲躳躴躵躶躷躸躹躺躻躼躽躾躿軀軁軂軃軄軅軆軇軈軉車軋軌軍軎軏軐軑軒軓軔軕軖軗軘軙軚軛軜軝軞軟軠軡転軣軤軥軦軧軨軩軪軫軬軭軮軯軰軱軲軳軴軵軶軷軸軹軺軻軼軽軾軿輀輁輂較輄輅輆輇輈載輊輋輌輍輎輏輐輑輒輓輔輕輖輗輘輙輚輛輜輝輞輟輠輡輢輣輤輥輦輧輨輩輪輫輬輭輮輯輰輱輲輳輴輵輶輷輸輹輺輻輼輽輾輿轀轁轂轃轄轅轆轇轈轉轊轋轌轍轎轏轐轑轒轓轔轕轖轗轘轙轚轛轜轝轞轟轠轡轢轣轤轥车轧轨轩轪轫转轭轮软轰轱轲轳轴轵轶轷轸轹轺轻轼载轾轿辀辁辂较辄辅辆辇辈辉辊辋辌辍辎辏辐辑辒输辔辕辖辗辘辙辚辛辜辝辞辟辠辡辢辣辤辥辦辧辨辩辪辫辬辭辮辯辰辱農辳辴辵辶辷辸边辺辻込辽达辿迀迁迂迃迄迅迆过迈迉迊迋迌迍迎迏运近迒迓返迕迖迗还这迚进远违连迟迠迡迢迣迤迥迦迧迨迩迪迫迬迭迮迯述迱迲迳迴迵迶迷迸迹迺迻迼追迾迿退送适逃逄逅逆逇逈选逊逋逌逍逎透逐逑递逓途逕逖逗逘這通逛逜逝逞速造逡逢連逤逥逦逧逨逩逪逫逬逭逮逯逰週進逳逴逵逶逷逸逹逺逻逼逽逾逿遀遁遂遃遄遅遆遇遈遉遊運遌遍過遏遐遑遒道達違遖遗遘遙遚遛遜遝遞遟遠遡遢遣遤遥遦遧遨適遪遫遬遭遮遯遰遱遲遳遴遵遶遷選遹遺遻遼遽遾避邀邁邂邃還邅邆邇邈邉邊邋邌邍邎邏邐邑邒邓邔邕邖邗邘邙邚邛邜邝邞邟邠邡邢那邤邥邦邧邨邩邪邫邬邭邮邯邰邱邲邳邴邵邶邷邸邹邺邻邼邽邾邿郀郁郂郃郄郅郆郇郈郉郊郋郌郍郎郏郐郑郒郓郔郕郖郗郘郙郚郛郜郝郞郟郠郡郢郣郤郥郦郧部郩郪郫郬郭郮郯郰郱郲郳郴郵郶郷郸郹郺郻郼都郾郿鄀鄁鄂鄃鄄鄅鄆鄇鄈鄉鄊鄋鄌鄍鄎鄏鄐鄑鄒鄓鄔鄕鄖鄗鄘鄙鄚鄛鄜鄝鄞鄟鄠鄡鄢鄣鄤鄥鄦鄧鄨鄩鄪鄫鄬鄭鄮鄯鄰鄱鄲鄳鄴鄵鄶鄷鄸鄹鄺鄻鄼鄽鄾鄿酀酁酂酃酄酅酆酇酈酉酊酋酌配酎酏酐酑酒酓酔酕酖酗酘酙酚酛酜酝酞酟酠酡酢酣酤酥酦酧酨酩酪酫酬酭酮酯酰酱酲酳酴酵酶酷酸酹酺酻酼酽酾酿醀醁醂醃醄醅醆醇醈醉醊醋醌醍醎醏醐醑醒醓醔醕醖醗醘醙醚醛醜醝醞醟醠醡醢醣醤醥醦醧醨醩醪醫醬醭醮醯醰醱醲醳醴醵醶醷醸醹醺醻醼醽醾醿釀釁釂釃釄釅釆采釈釉释釋里重野量釐金釒釓釔釕釖釗釘釙釚釛釜針釞釟釠釡釢釣釤釥釦釧釨釩釪釫釬釭釮釯釰釱釲釳釴釵釶釷釸釹釺釻釼釽釾釿鈀鈁鈂鈃鈄鈅鈆鈇鈈鈉鈊鈋鈌鈍鈎鈏鈐鈑鈒鈓鈔鈕鈖鈗鈘鈙鈚鈛鈜鈝鈞鈟鈠鈡鈢鈣鈤鈥鈦鈧鈨鈩鈪鈫鈬鈭鈮鈯鈰鈱鈲鈳鈴鈵鈶鈷鈸鈹鈺鈻鈼鈽鈾鈿鉀鉁鉂鉃鉄鉅鉆鉇鉈鉉鉊鉋鉌鉍鉎鉏鉐鉑鉒鉓鉔鉕鉖鉗鉘鉙鉚鉛鉜鉝鉞鉟鉠鉡鉢鉣鉤鉥鉦鉧鉨鉩鉪鉫鉬鉭鉮鉯鉰鉱鉲鉳鉴鉵鉶鉷鉸鉹鉺鉻鉼鉽鉾鉿銀銁銂銃銄銅銆銇銈銉銊銋銌銍銎銏銐銑銒銓銔銕銖銗銘銙銚銛銜銝銞銟銠銡銢銣銤銥銦銧銨銩銪銫銬銭銮銯銰銱銲銳銴銵銶銷銸銹銺銻銼銽銾銿鋀鋁鋂鋃鋄鋅鋆鋇鋈鋉鋊鋋鋌鋍鋎鋏鋐鋑鋒鋓鋔鋕鋖鋗鋘鋙鋚鋛鋜鋝鋞鋟鋠鋡鋢鋣鋤鋥鋦鋧鋨鋩鋪鋫鋬鋭鋮鋯鋰鋱鋲鋳鋴鋵鋶鋷鋸鋹鋺鋻鋼鋽鋾鋿錀錁錂錃錄錅錆錇錈錉錊錋錌錍錎錏錐錑錒錓錔錕錖錗錘錙錚錛錜錝錞錟錠錡錢錣錤錥錦錧錨錩錪錫錬錭錮錯錰錱録錳錴錵錶錷錸錹錺錻錼錽錾錿鍀鍁鍂鍃鍄鍅鍆鍇鍈鍉鍊鍋鍌鍍鍎鍏鍐鍑鍒鍓鍔鍕鍖鍗鍘鍙鍚鍛鍜鍝鍞鍟鍠鍡鍢鍣鍤鍥鍦鍧鍨鍩鍪鍫鍬鍭鍮鍯鍰鍱鍲鍳鍴鍵鍶鍷鍸鍹鍺鍻鍼鍽鍾鍿鎀鎁鎂鎃鎄鎅鎆鎇鎈鎉鎊鎋鎌鎍鎎鎏鎐鎑鎒鎓鎔鎕鎖鎗鎘鎙鎚鎛鎜鎝鎞鎟鎠鎡鎢鎣鎤鎥鎦鎧鎨鎩鎪鎫鎬鎭鎮鎯鎰鎱鎲鎳鎴鎵鎶鎷鎸鎹鎺鎻鎼鎽鎾鎿鏀鏁鏂鏃鏄鏅鏆鏇鏈鏉鏊鏋鏌鏍鏎鏏鏐鏑鏒鏓鏔鏕鏖鏗鏘鏙鏚鏛鏜鏝鏞鏟鏠鏡鏢鏣鏤鏥鏦鏧鏨鏩鏪鏫鏬鏭鏮鏯鏰鏱鏲鏳鏴鏵鏶鏷鏸鏹鏺鏻鏼鏽鏾鏿鐀鐁鐂鐃鐄鐅鐆鐇鐈鐉鐊鐋鐌鐍鐎鐏鐐鐑鐒鐓鐔鐕鐖鐗鐘鐙鐚鐛鐜鐝鐞鐟鐠鐡鐢鐣鐤鐥鐦鐧鐨鐩鐪鐫鐬鐭鐮鐯鐰鐱鐲鐳鐴鐵鐶鐷鐸鐹鐺鐻鐼鐽鐾鐿鑀鑁鑂鑃鑄鑅鑆鑇鑈鑉鑊鑋鑌鑍鑎鑏鑐鑑鑒鑓鑔鑕鑖鑗鑘鑙鑚鑛鑜鑝鑞鑟鑠鑡鑢鑣鑤鑥鑦鑧鑨鑩鑪鑫鑬鑭鑮鑯鑰鑱鑲鑳鑴鑵鑶鑷鑸鑹鑺鑻鑼鑽鑾鑿钀钁钂钃钄钅钆钇针钉钊钋钌钍钎钏钐钑钒钓钔钕钖钗钘钙钚钛钜钝钞钟钠钡钢钣钤钥钦钧钨钩钪钫钬钭钮钯钰钱钲钳钴钵钶钷钸钹钺钻钼钽钾钿铀铁铂铃铄铅铆铇铈铉铊铋铌铍铎铏铐铑铒铓铔铕铖铗铘铙铚铛铜铝铞铟铠铡铢铣铤铥铦铧铨铩铪铫铬铭铮铯铰铱铲铳铴铵银铷铸铹铺铻铼铽链铿销锁锂锃锄锅锆锇锈锉锊锋锌锍锎锏锐锑锒锓锔锕锖锗锘错锚锛锜锝锞锟锠锡锢锣锤锥锦锧锨锩锪锫锬锭键锯锰锱锲锳锴锵锶锷锸锹锺锻锼锽锾锿镀镁镂镃镄镅镆镇镈镉镊镋镌镍镎镏镐镑镒镓镔镕镖镗镘镙镚镛镜镝镞镟镠镡镢镣镤镥镦镧镨镩镪镫镬镭镮镯镰镱镲镳镴镵镶長镸镹镺镻镼镽镾长門閁閂閃閄閅閆閇閈閉閊開閌閍閎閏閐閑閒間閔閕閖閗閘閙閚閛閜閝閞閟閠閡関閣閤閥閦閧閨閩閪閫閬閭閮閯閰閱閲閳閴閵閶閷閸閹閺閻閼閽閾閿闀闁闂闃闄闅闆闇闈闉闊闋闌闍闎闏闐闑闒闓闔闕闖闗闘闙闚闛關闝闞闟闠闡闢闣闤闥闦闧";
kanjiMegaStringLength = utf8.len(kanjiMegaString);
	
local LeetReplaceLetter = "";

function toLeetSpeak(msg)
	
	local out = "";
	
	
	
	for i = 0, strlen(msg)
	do
	local c = string.sub(msg,i,i);--character
	
	
	wasAnExceptionCase = 0;
	--replace periods if japanese text
	if (speakEnabled == nameModes['ENGRISH'] or speakEnabled == nameModes['CHINGCHONG'])--1 is on, 0 is off. 2 is japSpeak, 3 is random Kanji.
	then
	if (c == ".")
	then
	wasAnExceptionCase = 1;
	LeetReplaceLetter = "。";
	out = out .. LeetReplaceLetter;
	
	end
	
	
	
	end--end exclusive japanese case
	
	 --and insideSquareBrackets == 0
	 if (wasAnExceptionCase == 0)
then
	if (c == "[")
	then
	insideSquareBrackets = 1;
	end
	if (c == "]")
	then
	insideSquareBrackets = 0;
	end
	if (insideSquareBrackets == 0)
	then
	LeetReplace(c);
	else
	LeetReplaceLetter = c;--don't modify the letter.
	end
	if (c ~= "" and c ~= "[" and c ~= "]")
	then
	out = out .. LeetReplaceLetter; 
	end
	
end--end ~wasAnExceptionCase block
	
	end
	
	return out;
	
	
	
	
end

local alphabet = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z", "1", "2", "3", "?", " "}
--the special character "." indicates that i want to access the other array [for letters like IvI]
local replaceSub = {"Λα4AaæåªÅáàãÃÄäДдą", "βЪъЬьBb8ßБб", "ζς©Çç¢ć.", "DdĐ.", "εξЭэEe€єę∑", "Fƒ", "Gg69", "Hhн.",
 "Ii1", "Jj;", "Kkк.", "Ł.","Mm.","ηђИиЙйЛлń.","ФфΘOo0øðØº°◦●¤ó","PpÞþ¶","Qq","Rrя®Гг","Ss$§5ś","Tτ7╬†","Ццΰµ∩.",
 "Vv.","ώШωЩ.","Xx×Жж.","γЧчYyŸÿÝý¥Ψ","Žžż","1¹","2²","3³Зз","?¿"," "}
--▼ЫыΔΞ
--ÜüÚúÙùÛûёÊêËëÈèÉé3Cc
--russian alphabet lookalikes: БбГгДдЖжЗзИиЙйКкЛлПпФфЦцЧчЪъЬьЭэЮю
--note :: ѲѳѢѣѴѵ doesnt work in wow
--greek alphabet lookalikes: αβγεζηΘθΛλ
--polish alphabet lookalikes: ąćęńóśż
local replaceSpecial = {"a","b","((","I)","e","f","g","I-I","i","j","I<","I_","/\\/\\","/\\/","o","p","q","r","s","t","I_I","\\/","\\/\\/","><","y","z"};

local replaceJap = {"凡","官","っつ","D","ㄋ巨当せヨ","ヲ","G","廾キ升","卫エ个","し","长ㄍく","乚ㄥ心","川巾冊","んれ","回ロ","尸ㄕ","Q","尺","与弓さち","干十七ナ","ㄐㄙ凹ひム","V","山","ㄨ区凶父","丫ㄚ","乙"};

function LeetReplace(c)
LeetReplaceLetter = c;


length = 26+4+1;--table.getn(alphabet);

--Đ ' ● 2 3 ' 0 Ç 3À ÇÍ Ç● ●3● 3' 0 Ç 'Ç ƒ
--0● ' 'Đ '' Đ


if (speakEnabled == nameModes['LEETSPEAK'])
then
for i = 0, length
do

if c == alphabet[i] or string.lower(c) == alphabet[i]
then
local strToUse = replaceSub[i]
local randy = math.random(utf8.len(strToUse))
local subby = utf8sub(replaceSub[i],randy,1)

if (subby == ".")
then
LeetReplaceLetter = replaceSpecial[i]
else
LeetReplaceLetter = subby
end



end--end if




end--end for
end--end speakEnabled==1

if (speakEnabled == nameModes["ENGRISH"])
then
for i = 0, 26
do

if c == alphabet[i] or string.lower(c) == alphabet[i]
then
local strToUse = replaceJap[i]
local randy = math.random(utf8.len(strToUse))
local subby = utf8sub(replaceJap[i],randy,1)


if (subby == ".")
then
LeetReplaceLetter = replaceSpecial[i]
else
LeetReplaceLetter = subby
end

end--end if
end--end for
end--end speakEnabled==2
if (speakEnabled == nameModes["CHINGCHONG"])
then
local choisu = math.random(kanjiMegaStringLength);
if (LeetReplaceLetter ~= "?" and LeetReplaceLetter ~= " ") then
LeetReplaceLetter = utf8sub(kanjiMegaString, choisu, 1); end
end--end speakEnabled==3





end--end function LeetReplace(char c)

function LeetIncoming(ChatFrameSelf, event, msg, author, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
  
  
  return false, msg, author, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 --substitute newMsg for msg when returning
end

function replaceFractions(s)
--1/2
if (string.find(s,"1/2")) then
x = string.find(s, "1/2");
s = utf8sub(s,0,x-1) .. "½" .. utf8sub(s, x+3, 999);
--return s;
end


--1/4
if (string.find(s,"1/4")) then
x = string.find(s, "1/4");
s = utf8sub(s,0,x-1) .. "¼" .. utf8sub(s, x+3, 999);
--return s;
end
--3/4
if (string.find(s,"3/4")) then
x = string.find(s, "3/4");
s = utf8sub(s,0,x-1) .. "¾" .. utf8sub(s, x+3, 999);
--return s;
end


return s;

end
function detectLink(s)
--scan the string and return whether it has an itemlink in it somewhere or not.
for i = 0, utf8.len(s)-1 do 
if (utf8sub(s,i,4) == '\|cff') then return 1; end
end--end for
return 0;
end--end detectLink

function LeetOutgoing(chatEntry, send)

	-- This function actually gets called every time the user hits a key. But the
    -- send flag will only be set when he hits return to send the message.
    if (send == 1) then
	  local text = chatEntry:GetText(); -- Here's how you get the original text
	  
	  
	  --Replace 1/2 and 3/4 and stuff with the fractions. if addon is on or not, doesnt matter.
	  --local subby = utf8sub(replaceSub[i],randy,1)
local linkDetected = detectLink(text);	  
	  text = replaceFractions(text);
	  
	  local newText = text;
      if strlen(text) ~= 0 and speakEnabled ~= nameModes['DEFAULT'] and linkDetected == 0
	  then
	  newText = toLeetSpeak(text);   -- modify the text.
	  
	  end
	  
	  chatEntry:SetText( newText );     -- send the new text back to the UI
	  
	  insideSquareBrackets = 0;
	  
	  
	  
    end
end

function Leetspeak_initialize()


	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL",LeetIncoming);
	ChatFrame_AddMessageEventFilter("CHAT_MSG_EMOTE",LeetIncoming);
	ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD",LeetIncoming);
	ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER",LeetIncoming);
	ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY",LeetIncoming);
	ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID",LeetIncoming);
	ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER",LeetIncoming);
	ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_WARNING",LeetIncoming);
	ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY",LeetIncoming);
	ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER",LeetIncoming);
	ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL",LeetIncoming);
	ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE",LeetIncoming);
	hooksecurefunc('ChatEdit_ParseText',LeetOutgoing);
	
	------------------
	
	leetspeak_bgframe:SetPoint('CENTER',-25,-150);
leetspeak_bgframe:SetFrameStrata('HIGH');
leetspeak_bgframe:SetSize(100,16);--80


local tex = leetspeak_bgframe:CreateTexture("ARTWORK");
 tex:SetAllPoints();
 tex:SetTexture(0.1686274509803922,0.0588235294117647,0.003921568627451); tex:SetAlpha(0.80);
 local titleText = leetspeak_bgframe:CreateFontString("titleText",leetspeak_bgframe,"GameFontNormal");
 titleText:SetTextColor(1,0.643,0.169,1);
 titleText:SetShadowColor(0,0,0,1);
 titleText:SetShadowOffset(2,-1);
 titleText:SetPoint("TOPLEFT",tex,"TOPLEFT",20,0);
titleText:SetText("LeetSpeak");
titleText:Show();



-- Create the dropdown, and configure its appearance
CreateFrame("FRAME", "LSDD", leetspeak_bgframe, "UIDropDownMenuTemplate")
LSDD:SetPoint("TOPLEFT",leetspeak_bgframe,"BOTTOMLEFT",-24,0);
LSDD:SetFrameStrata('HIGH');
UIDropDownMenu_SetWidth(LSDD, 100)
UIDropDownMenu_SetText(LSDD, specialLeetspeakModeName[speakEnabled]);

-- Create and bind the initialization function to the dropdown menu
UIDropDownMenu_Initialize(LSDD, function(self, level, menuList)
 local info = UIDropDownMenu_CreateInfo()
  --display
  local length = getn(modeNames);
  for i=1,length do
  info.text = specialLeetspeakModeName[i];
   info.checked = (speakEnabled == i);
   info.menuList = i;
   info.func = LSDD.SetValue;
   info.arg1 = i;--arg1 is used here as the SetValue argument.
   UIDropDownMenu_AddButton(info)
  end--end for
end)


-- Implement the function to change the favoriteNumber
function LSDD:SetValue(newValue)
speakEnabled = newValue;
UIDropDownMenu_SetText(LSDD, specialLeetspeakModeName[speakEnabled])
end

LSDD:Show();

	------------------
	print("|cff00ff00" .. "Leetspeak Initialized!");
end

