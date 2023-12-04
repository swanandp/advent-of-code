# noinspection RubyLiteralArrayInspection
def sample_lines
  [
    "467..114..", # 0
    "...*......", # 1
    "..35..633.", # 2
    "......#...", # 3
    "617*......", # 4
    ".....+.58.", # 5
    "..592.....", # 6
    "......755.", # 7
    "...$.*....", # 8
    ".664.598..", # 9
  ]
end

def neighbours(i, j_min, j_max, len_i, len_j)
  # add current row separately
  rows = [i - 1, i + 1]
  columns = ((j_min - 1)..(j_max + 1)).to_a
  [
    [i, j_min - 1],
    [i, j_max + 1],
    *rows.product(columns)
  ].select { |(x, y)| 0 <= x && x < len_i && 0 <= y && y < len_j }
end

def sum_of_parts(parts)
  sum = 0
  selected = {}
  rejected = {}

  parts.each_with_index do |part, i|
    number_stack = []
    indexes_stack = []

    part.chars.each_with_index do |c, j|
      if c =~ /\d/
        number_stack << c
        indexes_stack << j
      end

      if number_stack.length > 0 && (!(c =~ /\d/) || j == part.length - 1)
        number = number_stack.join.to_i

        select_number = neighbours(
          i,
          indexes_stack.first,
          indexes_stack.last,
          parts.length,
          part.length
        ).any? { |r1, c1| parts[r1][c1] =~ /[^.]/ }

        if select_number
          sum += number
        end

        number_stack = []
        indexes_stack = []
      end
    end
  end

  sum
end

p sum_of_parts(DATA.read.split("\n").map(&:strip))

__END__
.......855.442......190..................................969..........520.......59.............................................172..........
.......................-....@...21...........971........................*..............965.......577=..........316..465*169.................
........881.......881....635......*..........*.............%.577.....864.......873.........................742...*...............714..244...
.......*..../..................602......351...423....939.906...*.........899..-..........833..60..%....965...*....309......43......*.*......
....737......294..........321*.......................$.......337....511.*.........58..............305.*.......153.............130.....638...
..............................821.544*282.........#......391............165...............836..........112.......................*..........
..............$.....456.....................281....847...................................*....+.....................-448.@728....833........
.......830...34.......%.......911..........$............553........702......21....279.........226....................................*......
..........*......................+.....745......./...........&......../.....*......*...................192...247...40................504....
...........304..938.........258..................679...702..742..$.........656..645..916.......*........*...+........-...263&...............
...841*168.....*.......169../...........@.................%.......633.-758..........*.......993......410.........920.............*195...492.
..............988.186....................689............&.........................554...........@...................*245......794.......@...
....+489..............@.....866..........................354...........567.............949.969...913.....&10....&...........................
350...........691...72..787*..........189.....639.............+...........*771............*....................736.........#..........639...
.................................561.*........&.....449......693.192...........344.....-...........847.....................496.192.39*......
...912....792...................=.....925.............*..........-....175.232.....*.....887.156.........378.........183.................782.
.........*....217....955.644*...............609.....728.................*....*.....966.......*............*........*........427.494#........
.....+...49......-.....*.....389........*......*812...................811...327............600..........233........320.&10...&..............
...155...............259..........629.646..............*194...111...............%...................998.....292................872..........
.......444.......648.....730.154....*.....657..$....816........*.....%.......618..123.....-...........*.......@........772.@....+.......*200
..........*.........*.....&....*............*..208......168#..305....510...........*.....907.........901.........582.....$.238........50....
........544.......935.........344..........106............................271.......849......-............890...............................
.....................................791.......=.................447*55.....*.............504.............*...........504............439....
..675...........................#547.$...211.197.......814....22.............115.....................-...39..................307.499*.......
....*..........169.....%......%..........*..............*.....*...229................................887.....974....+875....*...............
..933......696.........909.682............624..594*.....622.367....*........-.....-218..........358*............&........319....748.978.....
......546.....*.....................817............636...........562.........716..........730.......195.....897.....-.......................
..18...*......206...890............/............*.......3...-..........286.....................................$...817......................
.....404............*...334..........706...924..153.800..+.683......1.......685........*160.................................29..........579.
..................312.........498.......*....*.......@.............*....495....*....435............498..........83............*618..-.......
......./................*255............756..132.595...../......373..#.....#.286....................*......901..............*......526......
.......283...351.....472..........990*..............*..42............815.........85..............996..........*......*418...486.............
426...........................=.......254..........305..........859..........#..-.......491.-.............204.355.780.............../.......
....976.........$.........582.500.............67...........937...$.........267......551.@...915..$........*.........................653.....
........801.....441...740*......................*....145..$.........................*............442...990..........494.................183.
..1........&...............$.................96..950...*......................429..592./....................922....@........................
.......427...%.....%..680...798..63............*......163....580..........283*..........700...882............*..............=....423*.......
...........524..474......*........*....843.456...670...........*..96*986..........839.......=...&....952.330.726....@.......484........916..
......500................632....27..*......=.......*..=.............................#..739.953.........&.*..........929.978...........*.....
..........157........................821........384..95............*531...489..478....&...................950......................295......
......@.........=.........................................31....346...............*...................779........247.......761..............
854.6..10.....174...........726%.965..........-852.......*...........642.=260...+.462....457...........*............-.......*.........-.....
...*...................32$..........................272*........89.....*......310.........#.......894...83...251.............408.721.303....
.............................................771........406......*......................*........$..........*.....227$.............*........
........*.260..758.......*360.....213.......#......425#........49....968........944*131.645..410......*240...354........611.....528.........
.....716.....*........412...........+...................470.............$.......................*..155......................256.............
..........867.........................348..........69......*852..................419...........798........605.........*787.=.......3*994....
.....443......565.......*....793..744.*..............*270................529......+.................432...........323........+...*..........
.................*...159.467.....#....612.....=.214............-....805./....911................49.....*.............+.878*..704.382.%900...
.490...542........46........................878...*..........512......*........#....336...445........898........212*........................
....+.-......868...................................19................508.....$......@........*..............192.....143....636..............
...............*.............592............176.......608-........*......%..290.-........#....620.....+........*..........*..............814
............*...586.......60....*.......-.....@.545.@............99....536......815....820........./...598...373.....501....331.........$...
....985..776..........4...*......704.217.........+...531....709............308...................339............................746.........
....*...........359..+..869....................................*...........*..........262.................139...........164...........981...
.....951...........&..........408...315.564.................222..........781.................249.....995...+..........$.*....205.404.*......
..............351@............*............*.......*../............289.......711......946...*....................102.34.7.......*....65.....
.................../102....550............137...254....772..599+....*...+..%................734.@.......+...................................
....715......591.................................................926...767..719..322............229..721...................../.......*563...
.......*889...$..@..........*.......188......401.......566......................%................................*873.....801.....%.........
.................690.....948...908.@....&....*.../622.....%..............%..........655...676...404.374.....=.747.............622..144......
...*409.......=.................*.....379..340......................817.850..780.......+.*............*...510.....886..974.......*..........
844.........622....241*313...475.............................170......*........*.........371..147.............532.........*325....778...802.
.......................................155.&.................@.....480...566..731..440.........*...........%...=..-373......................
........931..................787....26*....178........372................@........=.........890............540............./........580.500.
.../.....-......988.......94.*.................494....*....*900..339..........652................177.4................%..762................
..112.............*.606.......423................#.831..227............696..............814......*..................215.............428.....
......247*.....172..=...................955...................%...132......493............*.....43....276.........&.........&...............
..........10.............508..383..409...&..............285..860.%..........%.........916..406..............685....760....473.834...........
..620.395......................-....*......*.......+...%................................*.......496............................*............
....$.%...760.......$......390.....361..991.285.522....................................437....&........332#.60................302.533.......
..........*.........828........648................................@....864..........*.......632....190............................*.........
220.209.626...802.................................198..961.......901....../.135..294..................*...843.......178............980.$....
....#...........*.....................493...42.....#.........&.............................582......993..*..........*...908.............916.
..............207..............983......./.*.........269-.223..187.....104...206...827..73.*............542.901.583..78....*................
.......................97.627...../.........856................*...716......$........#.%....357.............*.............238.........70....
.........................*..../................................168...=.....................................186.....747-................*....
....374....747-......*.....525.....92...449.....&..................#...........376...88.........580..447.........................342.814....
191*..............156.868............*.*.....33.973...........910.176......433...*....*.........%.................*792............*.........
.......+......&...........246......767.133..*.....................................629..928.............233.....945......459....778...849....
.....493....268..........-...................508...619.....%420....67$.....458....................=.......%./............*..................
.............................110*....623*331......./.......................#.........263....610.297.........902.......100.....-.473...231...
.........................336.....482................................502................&....*....................-.........542...*...%......
.924....................*.....................#....853......518......*...371.....905+.....412.................817.................97........
....*671.770...891.%...374...589.....774...757.....*.................8......*............................................708..............79
...............-...638..........*.....*.............431.....................104..........552.........346.........%.........*................
.................................44...995.................................................*..........*..........369........177.....996......
......949................-.....................351.........................557...........777..........454..538......625................120..
.......*......242.....201.............953........*......$..957.163...636......-...............-.............*...777..*..............&.......
......169.....$............538...249.......840...900...256....*........*.229...........110.196..............699....*..502..........861.*....
..........239................................*.......................465...*......&914...=.....*.......*412......147...................392..
..........*........526......=..........670....613.............625.55...................*.....572....322..............235..........515.......
214....333........*......975.....358....*..&........205.......%...=......487........272.779......................107.%...........*..........
............215........................556..549.............................*................492..........+......*......359.......944.......
..899..........#..846...........446.............797...98..795.991..........248.+15....457..................664.115........@.................
....+.+.........................*.................#...$......*.......27...................842*86.............................580.813.....481
......683................288.582...159..................../...............457....................656.....464..99.....................753....
937*.............752.361*............*..........759=.......635.*550................810@.200*44....*...../.....*...@........927..........*519
...........*401.*...........41....568................$674...............*977.................................383.306..........*826..........
........413......143.670....*............620....................%.................957..150.138.33.489..............................916......
.............542......*.....322.....................808......585.....-.646.......-........*.......*..........#959....732...724*328...*..59..
.......4......+.....520..%.................294..483*...............56...*........................514....13*.............*..........35.......
........*712....234.....241............712*...................92.........370.....*550.......798............365...........922.....+....550...
....145......&..................498.&....................434.......291.........51...........+.......*.........................902.....*.....
.....@........776...*..........*.....877.....87....*.997*..........*..................285........775.845.........962.....651........509..321
82...................184.....418..........54*....35.........782%..201...........=734..*......$...................*........../...866.....*...
......416%........................749..................*816...........................830.204.................277......890.....&.........33.
....................961............*....*......319..861..................917..................976..$..............995....*..................
..920......#828.84..............338..348.64....@........614..............$.....781@............*..29.....875..229*....234.....312...........
.......456......-...&......................................*.................9............280.235..........*..............280*..............
......&.....277......841.....83.......554....442*769.......418.+603..15*882...%..........*...............920..759...............$.......876.
......................................*..............553..........................784.759......................@...533.......770..=.........
..........936...............*435....29...382.#.........*...603.......121....%..#...*....................&.........../............52......137
..................340....121.............*....260.....339......11.....*...991..255.970...928.294.........17..457............................
.......238.518....#..................569..163..............487..=.....578...................*.....*..........*.........86..362.......926....
.......#....*........*...........467...+.........610.=......&..................@19.....892.....678......44.893..%..627*....*...359..........
..........431.....450.146.................603...=....872.............745.................@...............@.....987............+.............
..........................$.........848..*..................%....745................443........591...957............................816*72..
.....892*.....87..191....33....@...+........424........780..611...%..........184%......*...831*......&.....948...............726............
............-...*...*..........301...904*.....*..........+........................527..494.......123..............................&.........
150.......183...530..872.................710...868.........436.824....727..577...*................*..............#498......&532.842.........
...............................-.....174......................*....&.....=...*.762...............340.312..705...........+...................
..........269....162...873*.....915.....*729.........995..321....102.*.....443........%....205........*....=......15...808......792.........
.333.......*...............425..........................$.*..........286...........556.......*......572...........*............%......348...
........520..766.=.....74*............692...813............81............152............%.....................@....91.......................
............+....670......720..169*......#........164..193......971...........+......991...%..559.288..720*....706........402..18...........
........383........................705.....763....*......*.........*.......6.270..........873....*.........109.............@....-....254*...
..........*....................226.........*...841....+...252...884.......*......48.....*..........................678=..................539
......911..713...192.594..570...*...........33.....786...............851.807....*....472.890......563......................=.522..../.......
.894%..*............*.........25....&671.................*475....145.%.......137.............953..*...36..125..249*......774...*.549....696.
.......90..273........94.........=...........667......132.......#........120.....*.......697..*..910...*....*......567.......240.......*....
.....@......*..........*.........294...@.......*..........595............*.....506.......*...655.....295.777......................%..896....
477.448.179..370....829..356.611......474......76...........*.........972..............726.......................642....829....287..........
.........................*.....*...........................384.............-................431....291.459#............*....................
.........296.......715.794..759...............590.................410.......233.............*.....#.....................477..342....729*....
.....989*...........................568..571.....*.488..98.......*........................123.577.............988...........*....$......285.
...............667.857*127............*....*..343..*............506...702..........295.................*......*.........600.....626.*.......
.......*563......*........................349.....945.................+......@........*....964%......33.642...431.......*............968....
....229..........48....=....*.....447......................%....745$..........569...787.........*.....................887...................
.......................369...515..............100...........174..............................633.973........................................
