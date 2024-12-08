# frozen_string_literal: true

def rows(input)
  input.map { |l| l.join }
end

def rows_reversed(input)
  input.map { |l| l.reverse.join }
end

def columns(input)
  input.transpose.map { |l| l.join }
end

def columns_reversed(input)
  input.transpose.map { |l| l.reverse.join }
end

def collect_left_rows(r, c, i0, j0)
  i, j = i0, j0
  row = []

  while 0 <= i && i < r && 0 <= j && j < c do
    row << [i, j]
    i += 1
    j += 1
  end

  row
end

def collect_right_rows(r, c, i0, j0)
  i, j = i0, j0
  row = []

  while 0 <= i && i < r && 0 <= j && j < c do
    row << [i, j]
    i += -1
    j += 1
  end

  row
end

def left_diagonals(input)
  r = input.length
  c = input.first.length

  r + c - 1 # total rows

  indexes = (r - 1).downto(0).to_a.product([0]).map do |(i0, j0)|
    collect_left_rows(r, c, i0, j0)
  end +
    [0].product(1.upto(c - 1).to_a).map do |(i0, j0)|
      collect_left_rows(r, c, i0, j0)
    end

  indexes.map { |l| l.map { |(i, j)| input[i][j] }.join }
end

def left_diagonals_reversed(input)
  left_diagonals(input).map { |l| l.reverse }
end

def right_diagonals(input)
  r = input.length
  c = input.first.length

  r + c - 1 # total rows

  indexes = 0.upto(r - 1).to_a.product([0]).map do |(i0, j0)|
    collect_right_rows(r, c, i0, j0)
  end +
    [(r - 1)].product(1.upto(c - 1).to_a).map do |(i0, j0)|
      collect_right_rows(r, c, i0, j0)
    end

  indexes.map { |l| l.map { |(i, j)| input[i][j] }.join }
end

def right_diagonals_reversed(input)
  right_diagonals(input).map { |l| l.reverse }
end

def x_corners_coords(i, j)
  deltas = [
    [-1, -1], [-1, 1],
    [1, 1],
    [1, -1],
  ]

  deltas.map { |(di, dj)| [i + di, j + dj] }
end

def x_corners(input, i, j)
  x_corners_coords(i, j).map { |(x, y)| input[x][y] }.join
end

def solve_part_two(input)
  r = input.length
  c = input.first.length
  xmas_count = 0

  1.upto(r - 2).each do |i|
    1.upto(c - 2).each do |j|

      next unless input[i][j] == "A"

      if %w{MMSS SMMS SSMM MSSM}.include?(x_corners(input, i, j))
        xmas_count += 1
      end
    end
  end

  xmas_count
end

input = DATA.read.strip.split(/\n/).map { |l| l.strip.split("") }

# pp input
count = 0
count += rows(input).sum { |l| l.scan(/XMAS/i).length }
count += rows_reversed(input).sum { |l| l.scan(/XMAS/i).length }
count += columns(input).sum { |l| l.scan(/XMAS/i).length }
count += columns_reversed(input).sum { |l| l.scan(/XMAS/i).length }
count += left_diagonals(input).sum { |l| l.scan(/XMAS/i).length }
count += left_diagonals_reversed(input).sum { |l| l.scan(/XMAS/i).length }
count += right_diagonals(input).sum { |l| l.scan(/XMAS/i).length }
count += right_diagonals_reversed(input).sum { |l| l.scan(/XMAS/i).length }

pp count
pp solve_part_two(input)

__END__
XSMMXMASMXMXXMMMAMXSXXXXXMASXSMMXSMXASMMMSMXSXSASAMAAXXMAXXAXMMSAMXAMXXSMSMXMSXSSXMSMMXSMMSSMSXSAMXSXMASXMASMSMSXXXSXSSSSXMASXSSXMXSXMSMMMSX
MMASXSMXAASXSMMSXMASMMMMSXASXMAMAAXSSMAXAAMMMAMXMAMMMMMMSMXMASASXXSSMXMXAASAMXSASAMXMMASAAXXAAXMASMSAMAMASXMAAXXMASAAXAAXMASXMAXAMASAAMAXAXX
ASAMXSAMSMMAAXASAAAXAAXAAMXSAMAMMXMMASAMSXSAMAMASMMSAXAAAMXAAMXMAXSAMSAMSMSXSMXMMXMAMMASMMSMMMXSAMASXMASXMAMSMSMMSAMXMMMMMXAMAMSSMASMMMXMSSM
MMASAMAMXAMSMMASXMMMSMXAMXMSAMXMSASXMMMMXASMSMMAMXMMAMMSSSSMMMSMSMMAMXAMAAXASAMXSSSMSMMSAAXXAAMMAMAMXXXSXSXMAMXASXMASAMXAMMSSMXAXMAMAASAXMAM
XSAMMSSMXXMAAAXMAXXXXXSSXMASAMAASAMSXXMASMMXAAMXSMSSSMMAAXAAXAAAAMSSMXSSMMMAMMAMAASAAXSSMMMMMSSSMMSSSSXSAMXSASXXMASMMAXSASAAMXMMXSASXMSMSSSM
AMASAAAXMASXXMSAMXSMMAXMASXSAMSMMAMMMSMMMAXSMSSXAAAAAAXMSSSMMMMXMXAAXXMAMSSXMXXAMAMSMSMXAAAAAMAAMAXAAXXMXSASAXMASXMASXMSAMMMSAXXASXSMAXXAAAA
ASXMMSSMMXSAXSXMMASAMSMSMMASMMMASMMAAAAXMSASAAMMMMSSMMMXAAMXAXSMMMSSMXMAMAXAMASXMXAAXMAMSASMSXMMSSSMMMXXAMMSAMSAXASAMXMMSMSMSASMXSAXMAMMMSMM
XXMAAMMAXAMAMAAAMAXSXAAXXXAXAASXMASMSMSMMMAMMMSXXAXXASXMASXXSAMAXAAAAXMAMXSAMAMXAMSSMMSAXAMMXAAAAXAAAXMMMXMMAMMASMMMSAMAAXAASXMAXMXMASXMXMXM
AASMMSSSMMSSMSSMMSXXSMSMSMSSMMXMXMAMMMMASMAMSAMMMSMMMMASXMAXMAMXMMSSMMSASXSAMSSSXMAMXAASAMXASMMMXSMMMSMAXSSSSMMMMXAAMMXSSSMXMAMXMXSXAMAMMMAM
MMMSAAXXAAAXAXAXAMMMMXAAAAAAASMMAXXXSASAMXMMMASXAMASXMMXAXMXSXMXSXAMAMSXSASXMXAASMMSMSSMSXMMMMMXMSASAXXXXAXAASXAAXMSSXXMAXXAXXMAAXMMMXAMASAS
XAAMMMSMSMMSSSMMASAAMSMSMSSSMMAXAMXXMAMXMASMSAMXXSAMAXXSMMMMMAXASMMSSMSXMAMMMXSMXMMAXMAAMXMXSASAASAMASAMSMAMXSSMSSMAXMASAMXMSMSSSXMAXMAMMSAS
XMASXMXAAAXAMAXSAMMXMAXXXXXAXSMMSMMAMXMXSXSAXMMSMMMSMMMMXXMAMSMMSAMAAAXMSAMASAMXXSSMSSMMMAXXSASMXMXMSSXAAXMXAMXMXAMSSXAMAXMASAAMAASAMSSMAMMM
MMXMXSXMSXMXMSAMXSAMSMMMMSMMMSAAAAXAMXSASAMXMMAMAAXXXXXAMSSMSXAMSXMMMSMASASAMASAMXAAAXMAMMSMMMMMMMMSAMASMSXMAMAMXXXXSMXSAXSASMSMSMMAMAMMXMAS
ASASXMAMXAMXXMASAMXXAMASXMASASMMSXXASAMASMMSXMASMMMSAXMXMXAMSXSMMXSAAAMXSAMASAMXXSMMMXMSAMXMASAMAAXMASAMASMMMSMSMMXMXSAAMMMAXXMAXMMXMASMSSXS
XSAMXAMASAMAXSXMMXXXASASMSMMASXMAXSAMMSMSAASMSMSMSXAMXSSSMAMMAXAAASMSXMXMASAMXAMMMMMSAAMXMASMSXSSSSSMMMMMSAMAAXAAAAMAMXMXAMAMSMMMMSSMMMAMAAX
XMAMSXSMSXMXMAMXXAMXMMXSAAAMXMAMAXMSMASASMMSAAXXAXXMXSAAAXXMMASAMXSMXAAXSXMMXSAAAXAAXMSMMSMSXMAAAMMAMXXAXXAMMSSSXSAXXMXXMMXXXAAAAXXXAAMAMMMM
XMAMXAXXXMAXXAMMMMXAMXAMMSSMMSSMXSAXMAMAMAMMMMSMMMXXXMMXMMSXMASXMASASMMMSSMAMSASMSMSXXAXAAAMAMXMMMSAMXSSXSMMXMAXAXXXSSSMSSSMMMSSSSSSSMSSXMAX
XSAMMXMAXMMSSMMXAASXMMXSMMXMAAAXXMMAXSMSMXSAMXAAXAXMXAXSMMMAMASAMAMXMASAXAXMMXMMAAAAXMASXMMSASAMAAMASMAMXAAXMMAMMMMXMXAAAXMAMXAAMAMXMXMAMSMS
ASASAAXSXSAXAAMMXMAAAXASXMXMMSSMXMMMAMAAAMMMSSSSMSAMAXSAXAMAMXSAMXXMSMMASMMXMAMMXMMMSMASXMAMASASMXSASMAMSXMMSMXMAAMAMSMMMSSMMMMSMAMAMAMAMAAA
XXXSXSAMAMMSMMSAMMSMMMMMAAAMAMMMAXASAMXMMMAXAAMXXXXXAMXMSMSMMXSMMSXAAXXAAXMASASAMXMAXMXMAMMSAMAMAAMMSMMMSAAASMMSSXMAMAXAAAAXMASMMXSAXAXAXMSM
MMMXAXMMAMXXXAMMXAAAMMSSMMSMAMASXSMSMSMSMSSSXSMSMMMMXXMXSMAMSMMAAXMSMSMSSXSASASMSAMMXAMMXMMAXMAMMMSASAMASMXMXAXXXMMMXMSMMSMMXXXMAMSASMSMSAMX
XAAMSMXSSMXAMXSAASXSMAAAAAMXMMAMAMXSAAAXASAXMXAXAAASMSMASMXMAAXMMSMAMMMAAAMMSAMASMSXMASXAAMAMXXSXXMMSAMAXSAXSMMMXMASXXXXAAMSSSMSXMMXMMAASASX
SSSXMMXMXAMXXAXXXMMMMMSXMMSASMSMXSAMMMSMMMMMAMSMMSXSAAMAMASMMMSAMAXASAMMSSMAMAMXMMAMSAMMMSMMSXAMMMMXSAMASXMAXXAXXSAXAMXMMXSAAAAMAMXMXMMMSAMM
MAMXMMSMSXMMMMSMSAAXMAXAMXMAMAMXAMXSAXAAMMXXXAMMXXMMMMMSXMSAAXXAMMSMSXXMAMMXSMMMSMXMMASMXAAMXMAMSASXMAMXMAMMSSSMAMASXMSAMSMMXMMMAMXMASXXMAMX
SASAXSAAXXAXAXAASXMXMASMSXMAMSMMXSASASMSXSMSAMAMXMXAXMAMAASMMSXAMXAXSXXMAMSAMAAAAXXASAMXSSSMXSXXMMSAMSAXMSMAAMAXMMMMMAXXMAAXXSASMSXMAXAXSMMS
SASMMMMSMSMSMMMMMAMSMMSASXMMSMASAMMSAMAAAAAXSXAAMAMXSMAMMMMMASXMMXMMMMMSMMMASXMSSMSMMASXAAAMXAASMXSAMXSMAXMMMSAMSMMAMXMSSSSMAMASAAMMASXMMAAA
MXMXMSXXMAXXMASASXMAAXMXMAXXAXMMAXXMMMXMSMSAAMSMXSXMMMSMSAMMXSAMASXMAXMAMXSAMAMMXMAAAAXMMSMMSMMAAMMASAMMAMAAMMAXAMSMSMAAAAAMXMXMAMMMXSAAXMSS
SAXAXAAMSSSXSASASXSXSMMXSXMSSSXSXMSMMASXMXXMMMMMMMMSAAXXSASMASAMASASASMXMAMASXSAMXMMMMSSXXMASAXSMASAMAMMAMXMSSSMMMAXAMAMMSMMSSXMSMXXXSXSAMXM
SXSMSMXMAMXAMASXMAMXXAMAMAXXAMAAMAAAXAMAXAMMXAAAXXASMXMASXMMMSAMASXMASXMMXMAMAMAMMSMXSAMXXMASXMAXMXMSSMMSAMXMAXAMSXSXSSXMAXXAAXXAXXSMMAAMSAM
XMAAXXAMMSMXMXSAMXMAMAMAXXXMMMMMAMXXMMMMMMSXSSSMMMMSXSMXMAXMXSMMXSXMAMMSMMSSSXXAMMAAXMAMSMMXMASMXXXMAMAAXXMXMAMMXMASMXMASMSMMMMSMSMSAMMMASAS
SXMASXXMAAAAMXSMMSMMMXSAXMMXAAXXSASXMSAMAXAXXXAMXSXMAXMASMMMMMXMAMXSAMAAAXAXAMSSSSMSMMAMAAXASXMXMMXMMSMMMSMAMXXSAMMMSXSAMAXAAAAAAAMSAMXXMSAM
SXSXMMMXSSSXXAMAXXSAAMAMAAMSSSSMMASAASXMMSAXSXSAMXAMSAMXAXMAXXAMXSASASXSXMMSMXAXMAXMMSASXMSAMXMXMAAMXSASXASASMMSAXSAMXMXXASMMXSMSMXSASAMXMAM
MXMAMMSMMAMMMASXMMMMXSASXSMAMMAAMAMMMMMMXAMXMAMSSXXMAASXSSSSMMMSAMASAMXAASXSXMASASAXAXXSAMMXMAXAMXMSASASAMMMMAXMXMMAXSXASMMMSAMAAMXSAMXAMXMM
MASMMAAAMAAASXMAMAAMAMAMAAMXMSSMMASMMSMMAAXSMSMAMASXMSMAAAAAASXXXMAMXMMMMSAMXMMMAAMMMSMMMMMAXXSXSAXMMMMXAXSSXMMSMMSSMXMAMAAAMXSAMMAMAMSSMSMS
SASAMSSSSMSMSMSAMXXSAMXMSXMAXXAXSXMXAAAMSSMXAAMAMXMASAMXMMMXMAAMSMSSXXAMAMMMASAMXMXAXAAAMAXSSMXAMXMMXMMSXMXMASASAAAMMMMSSMMMSMMAXMXMAMMMAAAX
MXSXMXXAXMMXSASXXAXMAMMMMMSSSSMMSAXMSSXMAMMMSMSMXAMXAMXMXXXSMMSMAAXXMMXMASASXSAMMXMMSSSMMMSXAXMSMSXMASAMMSMSMMASMMSMSMAMAMXAAAMAMAASXSSMMMMM
SMMMSXXMSXSAMMXAMSSXXMMXSAAMXMXAXAXMAMAMAXSAMXAAXSMSMSASAMMAXMAMMSMAMASMMXXMASMMSSMAAMAAXMAXSMAAAMSXXMAXXAAAXMXMXMAAAMXMAMMSSSMSMSMMAAAXMAXA
MAAASMSXSAMXSAMSMMAASMXAMMMSASMASMMMASXMMSMASMMSMMAAASMSAMXMMSAMMAMSMASAASMSMXMAAAMMMSSMMXMAXXSMSMMMSSMMSMMMXXAMASMMMXMMAMXMAMAXAAXMMMMMSASM
SXMMSAMMMAMXMMXMAMSMSAMXSAMSAMMAAAMXAMMSXXMAMAAAAMSMXMASMMMXMMASXXSXMXSMMMAAXMMMSSMMAMXMXSMAMXAMMMSAMXXAAXASXSASASMASAAMASAMMMSMSMSASXAXXMAX
AXSXMMMXSAMXXXASXMAXMXXAMAMXSXMSXMSMXMXMXSMSSMMSSMMXSMAMAAMAMSAMXMMMMMMMSMMMMSMAMMAMXSASAMMASMMMSAMASAMSMMASAMAMAMXASASASMMMAAXAAMXAMXSMXSAM
AMXAXXXAXASXMXMMAMXSMSMMSSMAXXMMAXAAMSASAXAAXAAXMASAMMASXMSAMAAXXMAXAXAAAASXMAMASXSMAXAMXMSAXAAAMAXMMAXAAASMMMSMXMMMSXMMMAXSMSMXMAMAMXAXAMAS
AAMMMSMXSAMASXMSMMSAAAAAAAMAMMASMMMAMSAMMMMMSMMMSAMMSSMMMMSXSSMMMSMSMMMXSMMASXSAXMXSSMMMMMMXSSMMSSMASMMMSMMAMSMAAMXAXAXXSSMMAAAMAXAAXXMMSSXM
MSMAASAMXASAMXXAAXMMXMSMSXMMMSAAAAMAAMXMXMAXAMXXMXSAAMAXXXMAAAAXXAAAMASXMASXMMMXSAXAXASASXAXXXSMAXSMMASAMASXMMAXMMMMSSMAMAAMMMMAMXXASMXMAMMM
AAMXXMAXSAMXSMMSMSASAMXAXAMXAMMXMXSSSMXMASASAMSAMXMMSSSMMAXAMSMMSMSMSASASAMAAXAAMXMXMMSASMASMAMMMMMXSAMXSMMMAMXMSXMAAAMAMSXMASXSMMSMMMAAMMAS
SMSMSMSMSXMAXAMAASAMMSMXMAMSXSAXMAMMAMSSMSAMAMXMSMSAAAAXSAMMXMMAMMMAMXSXMAMXMMMXMAMMMXMMMMXAMAMAAASMMXXXMMASXMAXMAMMMMMAXXXMASAMXAAAASMSXSAS
XXMAAAAASMMMSSMMMMXMAAMASXMXAMAXMAXMAMXAAMXMAMAMAMMXMMMMSASXAMASXAMSMAMMSMSSSSMSAMXAMAXXAXXMSASXXAMAMMMMMXAXAMSXSAMASXSMASXSAMXMMSSSMMAMAMXS
SAMSMMMXMAAXXMAMMMMMSXSASMMMSMAMSSMSMMSMMMASASASMSMSXMAASXMMMSAMMMMXXXXAAMMAAAASAMSSSMSMXSXXSASAASXMMSASASXSMSAMSAMXSAAXMMXXXSXXAAAMAMSMSMMX
SMMXMSMMSSMSMMAXAAAAAAMXMASAXMAMAAXAMMMMASXSASASXAAMAXMXSAMSMSMSAMAMMXMSSSMMMMAMAMAAMASAAMMAXAMMMMAXXMXMAMMAMMAMMMXXMMMMXMAMXMMMMMMMAMAAAAAS
XSAMXAAXAASAASMSSMXMSXSMSMMSSXXMSMMMSAAXMSMMMMAMMMMSAMXXSAMXAXASXMASAXAAAAMXMSASXMMSMAMMMXAMMMMXASXMASMMAMSAMSAMXSASAAXXAXASAMAAAXXMXMMXMMXX
SMXSMSSMSSMMMAAMASMXXXAAAXAAXMXXAXAMMXXMXXAAXMMMXSAMASAASAMMMMXSASXSXSXMSMMMMXAAXAAXMASAMAMSAMXSXSAAXSXMAXSAXSASASAMSXSSXSXSASMSSXMMSSXMSMSM
MSAXMAMAXMMMXMSMAMXAMSMMMMMSSMMSMSSSMSSMMSSMSMAMXMASAMMMMMAMXAMSAXAMASXMAMAASMSMMMXSMMSAXSMSASMXMSXMAMMSSXSMMMAMXMAMMMMXMMXSMMMMMXMAAAAAMAAA
MMMSASMSMSASMAXMASMXMAMASAAAXXAAXAAAXAAAAMAXXAAXAMAMAMXMAXSSSSMMAMXMAMAXMMMSMAXAMSASXXMMMMAXAAXMAMAMMMAAXXSSMMSMXSMMXAMASXASAMSAAAMMSSSMMSMS
SAMXMAAXAXASMXMSAMAASMSXMSSMSMSMSSMMMSSMMSAMXSMSSSXXMMSMSXXAMXMMMMXMXSMXSAMXMAXAMMASXMXASMSMXMASXSXMAMMSSMMAXAAAAXAAXXXAMMMXAMMMSXMAAAAXAAXA
SXSAXMMMMMSMXAMXMMSASAAXMAMXAAAAXAMSXMXXMXAMAAXXAAXAMAXAMXMXMAMXAXXMMSXAMASXMAXXMMAMAMMASAXAMXAXAAAXXSAAXAMAMMSMASAMXSMSSMMSSMSAMXMSMMMMSSSS
MMMMXAMMSXMASXMAXXMAMMMSMSSMMMMMMAMSAMXAMXAMSMMMXMXSMMMMAMXSSXSSMXMMAXMASAMXMAMSASXMASMMMXMXSMMSSMSAMMMSMSMMMMAXAAAMXSAXAMAAXMAMXXXXAAXXXAAA
MAXXMXAMXAMAMMSMSMXAMXXXAMMAMXAMXMMMAMXMAXAXASASAMAMASAMXAAAMXMAXASASXXMAXMXMAXMAMXMASMMSMSAAAAMMAXMMXXAAXXSAMXSSSMMAMMMMMMSSSMMSMMSSMMMMMMM
SSSMSMSSSMMAMAAXAMSSMXAMMMSSMMMSAASXMMMXAASXMAXMAMMSAMXMAXMMMXSSMXSAMAXASMSXMMSMSMXMASAMAAMSSMMSMXMASMSMSMAXXXAMMAMSXSAMXAAAXAAAAAAMMMMAAXAM
MAAAXSAAAMSXSSMSXMAMXSMMMAAAAXAMXXMAMXAMMMXAMXXSMMMMASXMASMXMXAXMXMAMMMXMAMSAAAMXMAXAXMSXSMMXXMSAMAAXXAXAMMMSMMSSXMAASXSMMSSSMMMMMMSAASXMSMS
MSMMMSMSMMAMMAMMMSMMAXAASMSMMMSXSXSAMMSMSXSSMSXXXAXMAXASXMMAMMAMXMSAMXMAMMMSMSSSSSSSSSMSAAAXAAXMAMXSMSMSXMAAXAXXMAMMXMMAMAMAMXMASMXMMMSAMAAS
XAAAAXXMXMAMXAMAAAAMSXSMSXXAMAMAAASASXAAXMMAAXASMSMSXSAMXMMSMMAMAASASASASAXXXXMXMAAAMAAXMSMMXSXSAMXMAAAAXXMXSXMMSAMMAXAAMMMAMMXMASMXMXSMSASX
SMSMSXSMXSAMXASMSSSMMAXAXAXXMAMXMASAMXMMMASMMMMMAAAAXMMMSMAMASASMMSASASASMSMMMSSMMMSMMSMXXAMXMMSASAMSMMMSSSMMAMMMMXXAXXMSSMSXMAMMXMAMXXMXMXM
MXAXMASXMMASMMMAMAAAMSMMMXMASMSAXXMAMMSXXMAMASMMSMMMXMASAMAXXMAMMAMMMMMXMMAAAAAAAXAXAXAXASAMASXMAMXXXMAXAMAASMMAMSMMSXMAAMMAAXAMMASAMSXSASAS
SMSSMAMAMMAMAMMMMXMXMMAAAAXAMASMSAMXXASMMSMSAXAAMXAAXXXXXMASXMSMMSMMSSSSMSXSMSSSXMMSMMAMXSXXXXAMSMSMMMXMASMMMXMAXAAMAAXMMSMSXMAMSASAMSASASAM
AAAXMAXAMMSSMMAMXSXAMSSMSXSAMAMSXXAXMASAAAAMMSMMSSSMSMMMSMXSXAXAAAAXXAAAMSXMAMXXMXXXXAXSAMMMSMMMAAAAMASMMMASXXSSSSSMSSMAXXAAASAMMAMMMMAMAMAM
MSMSMSSSSXMAMSASAMSMXAAXAXSMMAMXMSMXAASMMMXMXAMAXAAXMASAMXAMMSMMSSSMMMSMMSAMXMAAMMMMMSSMXSAAAAXSSMMSMAXAASAXMMXAAMAAAAMSMMMMAMASXMAXAXAMXSSM
XAXAAMAMXXMAMMMMMXAXMSSMMXSASMSMAAAXSMMMMXAMSASMXSMMSAMMSAMXAAXXAAXAAXAMSSXMAMMMMAAAAMAMAXXSSSMXXASXMXSAMMMMSMMMMMSMMSXMAMSSXSMMMXSSSSXSXXAS
SMSMMMAMXSMSSXAAMSSSXAAAXASXAAAMSMSXMAMAXMAMMMXAAMXXMAMSSXMMSSMMMSSSXSASXMASAMMASXSMSSSMMSAXMAMXSMMAXMAMXMXAMMAXMAMAXXAMAMAMMSXAXMAXAAAMXMSM
SMAMASXMAMXAMXXSMMAXMMMSMXSXMXMMAAAXXMSMSSXXAMXMXMASMSMAMMMMAXAXXXXAXMMMASAMAXSASMXMMXXAXMMMSSSMMASXMASMMXMSSSSXMASXMXXSAMXSAMSMSSMMSMAMSMAA
XMAMASAMASXXSAMXAMMXAXAAXAMMSXMMMAMMXMAXXAMSAMXXAMMSAAMAMAXMASMMMMMSMMAMXMASXMMMMXXAXAMSMMXMAAMXXASAMMMXMAMAMXAASASAAMXSXSAMAXXXAAXAXSAAAMMX
XXMMMXXMXSAAMMMSAMXMXSMSSXAAMAMXXAAAAMXSMMMSASASXSAMMMSSSMSMMMXAXSMMASMSSMMAMXSSMMSSMXMAAMMMMSMXSAXMMXSAMXMSSMMXMASAMMAMAMAXSMSMXSMSXSMSSSXX
SMSASMMSMMMMMAAXAMMSASMAMXMASMMASMSSSMSAMXASXMASAMXXAXAMAXAAXXSMMSAMAMXAXXSASAAAAAAAMXSMSMAAMAAAMXMSAMXAMXAMAXMXMXMMMMXXAMMMMAXMAXMMAXXAXMXM
XAMASXAAAAAAMMMSAMAMASMAMAXMAXMXMAMAAXSASMMSASAMXMAMMMSSMMSXMMXMASXMASMAMXXAMMXSMMSSMMMMAXSSSXMMSXXMASXMMSXMAMXAMMMMMASXMMAAMAMMAXAMMMMSXMAA
MSMAMMSSSSMMMAXMMSMMAMMSXMXSAMXMSMMSMASAMAXSAMXSXMAMXAMAMXXMAAAMASASASMAXSMSMSAXAAAAAASXSMMAMXSXMMXSAMXSAMAMSMSASASASXMASAMMXSAMXMMMXMMMASAS
AAMSMAXAAXASMSSMASAMMMMXAXXSXMAMMAAASMMAMSXMASMMXMASAASAMSXASXXMASXMASXMXSAMAMASMMMSMMXAAAMAMMSAXAXMASXMASMSAAAAMAXMMAMAMASAAMMXSXXAMXAMMMAX
SMSMMSMMMMMXAAAMAXXMAAAMXAMXAXAMSMMMAXSAMXMSAMAMAAAXMAMAXMXXXXSMMSASAMXMAMXMXMASMSXXMMMSMMSMSASXMSXSAMASAMXAMAMAMSMSSSMASAMMSSSMXAASMMSSSMMM
XXSXAAAMAAXMSMXMAXMMSMXXAMAXSSSXSXMXXXSXSAXMMMXMXMAMSASMSMMSMXSXASAMXMXMASXMXMASAXMASXXAAMAXMAMASXAMMXAMASMSXXMXAXAMAAXAMASXAAAXXMAMAMAMAASX
MXXMASMSMSMMXXXMSMSAXAAASMSMXAXAMXMMMMMSMMSAMSMXXXMASASXAAAASAMSMMMSASASASAMXMAMXMXAMMMXMMAMMAMXAMMMSMMSXMMXMXMXSMSMMMMXSXXMMSMMAXXXXMASXMMS
AXXXAXXAMAXXMAMXAAMAMMMMXAXMMMMSMMMAAASAXASAMAMSMMAMMMMMMMSSMXXAXAASASASASAMAAAXASMSMSSSSMSASMXAMXXAXMAXASXAMAXAXMAAXXAXAXMAMXXMMSMSMSASASAS
MMMSMMSSMSMSMSAMXSMSMMXXSAMXMAAAAMSSMSMMSXMXSASAAAMXSAMXXAMXAMSMSMXMAMAMXMXXXSMSMXAMASAAAAAXMMSSXMMXSMMSMMSMSASMMSMXXMSMASASXMAXXMAAMMMSAMAS
MAXAAXXASAAXXXMAMXMAMXMASMXXSXSSXMAMSMAAMAMASMSAXMSAAMXMASMMXMAXXXXMAMSSMSMMMXMAXMAMXMMMMMMMSAAAAXXMMMMAMXAMXMXMAMXMMXAXAXMXMMMMMMSMMAMMXMXM
SXSSSMXMSMMMMSMMMSSMXSAMSAMXMMMMMMASASMMSAMMSASASXXMMMASAAAAMXXMMMXXXAXAAAAXAASASMXSAMXSMXXAMMSSMMSXMASASMMSMASMMMAAXSMMSSMMSAMAAMAMSXSXMMSM
MMMXAXXXXXXAAAXAAMXXAMXXMMAAMAAAAXMMMSXMSASAMMMAMMAXXSMMSXMSSMASAAMAMASMSXMMSAMMSMXSASAMMMMMSAAAAAMASAMXMAMXMAAAASMMMSAAAAAASAXSXSAMAASASAAX
MASXMMMMMAMMMMXMSSSMXXSAMXXASMXXSSSXAXMASXMASXMMMSSMXMMMMSMAAXAXXXAXMAMXAXMMMMSMMMAXMMMMAAMXMMSMMMSAMMSSSSMAXAMSMXASASMMSSMMSMMMASMMMMSAMSSS
SASXMAXAXMASASAMXAAXAMMSSSMMXMAXXAMXXAXXSXMASXMAAAAXAAAXSAMSSMSSSSSXMASMSMSAAAAAAMMMSAMSSMSAXXAMXAMMSAMXAAMXSMXMAXMMMSAMAMMAMXMXAXMAXXMMMAMX
MASXSSSSXMAXAXMMMMMMMSAAMXMSAMMMMAMAXMSXSAMASMXMMSSSSXMSSXMAXAXAAAAMSAMXAASMMSSSXXSAMAMMXASXSMMSMASMXMSMSMXMAMSMMXSAXXXMASMASAMMXMASMXMASMSS
MSMMXMAXMMSSSSSXSAXAXMMSMXXXAMXXSSMMAXMASAMXSAMXMXAMAASXMXSSMXMMMMMMMASMMXMXMXMAMXMMSSMMMMMMSAAMMMMMAMAAAAMXAMXAAAMSSXMXAMXAMAMAMMAMXASASXAX
XAASAMXMXAAXXAAASXMASMXMAMSSMMSMMAASXAMAMASMSAMXMMSMSMMAAASAMXMASAASXMMXMASAMXXMASMMAXAAAXAASMMSAXASXSMSMSSMAMSMMMSAMXSAMXMSSSSSMMSASMMMSMSS
SSSMMXAXMMMXMMMMMMAAXMAMMMAAMAAAMSMMSXMASAMXSMMXAAAXMAMMMXSAMXSASXXXAXSSXAMXXSAMXMAMMSSSSSMXMSASXMXMAAAXMAAXAMXXAXAMXAXAMAXMAXMAAMXAMXAAMMMS
XMMAXSMSMAMSMSAMASMMAMMSXMSSMXSSMXAXAXMAMASAMMSAMXXSSSXXSASXMXMASMXSMMAMMSSMXSAMSSMMXAMXAMMMMMMMMSMMSMMMMSMMXAXMMSMXMMSSSMSMMMSSMMMAMSMMSAAM
MAMMMMXAMXSAAXASASAASXXMMMMAMXAAMSMMMMMASAMASASAMXSMAXXAXMMXMAXXXMMAXMAXXXAMXSAMAAXSMSSMMMAAXASXAAXXAAXMAXXMASMMMAMXAAXAMXAMXXAAAMXMASXAXMXS
MMMXAMSASXSMSMMMAXAMXSSMAXSAMMSMMAAAXAMASAMXMXXAMXAMAMMMMXMAMMMMASAMXSXSXSAMXSMMSSMMAXAASMSXSASMSMSXSSMMASASAAAASASXSSXMMSXXSMXXMMSAMXMMSSMM
SAXXAMXXXAMAAASMSMSXAAXSAXMASAMXSMSMSXSAMXSXSMSMAMMASXXAAAMXSAASXMMMASXMASXMAMXMAAAMXMMMMAAXAAMAAXXAMXAMAXMMSSSXSASAAAAXMASXMSSXAXASXMAXAAAA
SASMXMMMMMMSSSMAAAXMMSMMMXSAMXSASXMXAXMAMAMAXXAXAXXXMASMSMSAMXXMASXMASAMMMAMXSAMSSMMSXXSMMMMMSMSMSSMMSSMMMAAMXMAMXMAMMSXMAXSAAXMASAMXAXXXSMM
MAMXAAAMAXXAXAMXMSMXXAAAAMMXSXMASMMMMMSAMAMSMSSSMMSAMXMMAAMMMMMSMMMMSXXAMXXMASMMAMAMXXXSAMXMXMAMAMAMXAMASAMXSAMMMMMAXAXXXAXMMMSXMSXMASMMAXAM
SAASXSSMSXMXSXMXXXMMSMSMXSASMMMAMAAXMASXSXMMAXAAAASAAAXMXMMXSAMAMXASAMASXSAMASXMXMXAMXMSAMAASMSMXSAMMAMAMAMAMMMAAMSSMMSSMMSAMAXAXXAAAXAMAMAM
XAMXXAMXXXSAMASMMASXAMAASXMMAAMAMMMMMXXMXMMMSMMMMMSMSSSMSXXAXASXSSMXAXAXXXXMASXMASMMAAXSAMXMSAAXXMMMSMMSMSMSSSSSSMXAAAMAAASAMSSMMSXMASXMASXM
XSMSAMSAXAMXSAXASAXSMMSXMASMSMSSSMSSSSXMAAXAAAAXMXMXAXAMXMMMSMMAAXXSMMMSMMSSMMAMAXASXMMSAMMAMMMMMMXAXMAXAAAXAXXAMAMMMMMMMMSXMMAAAXAMAXMAXAMM
AAAXXXMMSMXMMXSMMMXXXAMASXMAAAXAAAAAMAASMSMSXSMSMAMMMSMSSSXMAXMMMMXAXAAXXAAAASXMSMMMAMASMMAASASAAMMMSMMSSMXMXMMSMSAMSXMXAMXXMSXMMSXMXSSMXMSS
SMXMAXXAAMAXAAMMAMXMSMSAMAMXMMMSMMMSMMMMAAAMXXAMMASAMXAAAAXMAMSAAXXMSMSMMMSMMMXMMAASXMASASMMSASXXMAXAAMAMMXSXMAAAMAMXAXSAMMSMAMSMSXMMAAAXSAM
AXMMMSMSASMSMASMMSXAAAMMXAMXMSMMXMMAMXMMSMMMAMAMMMSMSMMMXMSMASXSMSMXAMAAAMAMSXMASMMMAMASXMAAMMMXSSXSSMMASMASAMMMSMMMSAMXAMAAMAXAASAMXMMXMMAS
MMSAMAAMAAAXAAXXMAMXMSMSSMSASAMXASMMSXSAMXSMASAMAAMAMXXXAAAMXMXAXMASMSSSMSAXMAAXMXMSXMXXXSMMMXAXMMAXAXSAMMMSAMSAMAXXXXMSSMMSSSSMXSAMAXASMSAM
SXSASMSMSMMSMSSSMSSSXAMXAAXMXMASMSAAAAMXMMXMAMAMMMXAMXASMSMMXSSMMSAMXAAAASXSSMMMMMAXXSMMMMMMXMASMMSMSMMASXMSAMMASXMMMXMXXAXMAMXXXSAMXSASAMXS
XASAMAXXXAXXAXAAAAAXSMSMSMSXSXXMASMMMSMMASAMSMXSAMXMSMXAXMAMAXAMAXAXMMSMMMAAMAAXAAXXASXMAAASASAAXAXAXAXAMMMXAMSMMMAAMXSXMXMMAMSSXSAMMMAMXMAS
MXMAMMMMSXMASMSMMMMMMXSAMAMXSAMXXMAXXAXMAMMSAAMMMSAMXMSMXSAMMSAMMSAMXXMXSMXMSSMSXXSSXSAMSSMMAMMXMASXSMMASASMMMAAASMSXMSASAXXAMAXMSSMAMAMAXMM
AAMXMAAXXASXMXMMXSAAXAMMMSMMXAMXMASXSAMMASMMMSMAAMMMMXAAAXASXSMMXSMSSSMAXXAXXAMXXMXMASMMMAMMAMXSAAAXAXSMXMXAXMXXMSXXAASAMXXSAMXSAMXSASASXMMM
SMSSSSSXSAMAMAXMAMMXMMXSAAAASAMASMMASAXSASASAXMMMXSAMMMSMSMMXMAXAMSAAAMSSSSSMMMAMMAMXMXXSAMSSMAXMAXXAMXMSASMMMSMAXASMMMAMAMMASAMMXMMMSMMXAAM
AAAAXAMMXMSAMASMSSSMAXAMSMSMSAMXXAMAMXMMASAMMXSMMAMASAAAXAMSMSSMSSMMXMMMXAAMXAMXMMMMMAMMMAMXXMASXSMMMAXSAMAMAAAAAMXMAXXAMXMMAMXXAMSAMXMSSSMS
MMMSAMXSAMXMAMXMAAMMXMAXAXMXSXMASAMXXASMMMAMSAMAMMSASMSMSASAAXAAXAXSAMXMMMMMSXXAMSMMSASXSSMXMAMMAAAASXMXSXMXMXMMMSSSMMSSSMSMSSSMSMSAMMAXAAXX
XSXMMSASASXMMXAMMSMAAMMMXMXAMAMXMXMASMXAMXSMMASXMXMAMAMXSXXMSSMMMMAMMXAAXAMASAMXAAAXSASXAAAAAAAMSMSXSASAMXXMMXSAAXMASAMXAMXMAAAAMMSAMMSMXMMX
AMAMAMASAMAASMXXAXMSXSAXAMSSMAXSAMXXAXSXMAMASMMXMASAMAMAMMXXXMMAMXASXSASXSMASMASMMMMMMMMAMSMSSMXXXXAMAMXXXAXAASMMMSAMXXSXMAMMSMMMAMAMAXASXSS
AMAMAMXMMMSMMASMASAAAMXMSXAASXMMMMXMXXMASAMAMXXSMXSXSAMASMSMAMXAXSMSASAXAXMXMXMSASAMAAXXAXAAAXMSMSMSMSMSMSMMMMMAAXXXSMMSASXSAMXXMXSAMMXMMAAX
MSMSSSMMSMAMMAMMAMXMMMSXXMSMMSXSAAASAMSAMMMAXMASXXMASASAAAASAMSSXXXMAMAMSXSMSSXMAMASXSMMXSMSSSMAAAAAAAAAAXAAXXSSMSMAXXASXSXMASAXSAMMMXSAMMMM
MAXAAAAAAMASMXSXSMMAAAMAXAXMAXMSMXMMAXXXMSASASASAAXXXAXMMSMSMMAMXMSMMMSMXAXAMXAMAMXMMMAAMMAAAAXMSMSMSMSMXSXMXAMXAAAMMMXSASAMXMAAMASMAAMAXAAA
SSSMSMMXXXAMMAMMAMSSMASMMMMMAMMXSSSSMMMMXAMXASASAMXSMMMXAMASMMMSAAAAMAAAMSMSMAAMSXSAASMMSMMMSMMXMAMXAXXMASMXAMXMMMASXAAMASXMXMMMSAMMMSXSSSXS
AMAAAASXSMSSMMSAMMAXMXSAAMSMSSXAAMMASAXMASXSAMMMXMMXAMSASMAMMAXXXMXMMXMXAXMXAMXXXASMMAMAXAXAXXXXMAMSMSAMXSAMSSSXXSAXAXXMAMMAAXXMMASXXXAAXXMM
SSMMAMMAAXMAXAMXXMASMXXMXXSAASMMMSSMMXSXAXAMXMASXSXXXMAAXMASXXSXSSMSMSAMXMMSXMMSMMMSMMMXSMMSSMSMSSMMXSAMMMXMAAAXXMMXSSMMASMSSSMASAMXAMMMMSAA
XAMMSSMXMMSMMMSMSXAAXMXMMMMSMXXSAXAXMASMSMXMASAXMXAMSSMMMSAMXAMAXAAAASXSAAAXAAAAAAAAMXMMXMAXAAMAAMAMXSAMSASMMSMMXAAAMAXSAXXXAAMAMASMAMSAAAXM
SAMAAMXXMXXXAXAAXMMSAMASASAMXMAMXSSMSXXAAAASXMASMMXMAAAMXXASMMMSMMSMXMAXMMMXSMSSSMSXMAAMAMMSMMMMMSXMXMXMMASXMXXAXAMMSMMSSSMMSMMSSXXXAXXMSSSX
SSMMMSAMXSXSSSMSMSAXASASMMMXAAMXMMAASXMSMXMMAMAAXAAMSXMXXXMSASMXAXXASMSMASXAXAMXAAMXSSXSAMXAMXXSAMASMXMMMAMASXSSSMXAAXXXAXAAAXAMMMMSMSMAAAXX
SXSAMXMMASXMMXXAAMASAMXMMSSMMXSAASMMMAMAAASMSMSSSSMXMASMMMXSAMMSSMSAMAXSAMMMSAMXSMSXXAASAMSAMSMMASAMXAMXMAMAMXAAAXXSXMSAMMXSAMXMAAAAAAMXMMMM
SAMMSASMAXAMSSMMSSMMAMAXSASASASXMXXASMMMSMSAAAMMAAXMSAMAAAMMSMAAXASAMXMMXSXXSMMMXAXXMMMMMAMAMAXSMMMSSXSAXMMSMSMSMMMXMSXAXSXMMAXSSMSMSMSMMXSA
SASMSASMMSAMASAAXXASXMMMMASXMASMAMSMMMSXXXMMMMMXSMMMMMSSMSAAMSMXSXXMXSMAAXMMMAASMMMAXMMAMMSSSXXXAASMMASASXAAAMAMAMAXMSSXMASMSMMMMAAAXMXMAAXX
SAMXMXMXMAMMASMMMSMMMAMSMMMAMAMAAAAXAAMXMXMAMXMAAAXXAAAAAMMXMXMMXMASAMXMXXXAXXMSAAXMSAXXMXSAXXXSMMXAMXMAMMSMSMAMAMSSMXXMASXMASAMMSMSSMAAMMSA
MAMMMSXXSMXMXXXSAXAASAAAXAXAMXSSSSSSMMSAAXSASAMMSMMSMMXMMMXMXAMMAXAMMXAMSMSSSMXSMMSXXAXSXMMMMSXAAASMMMMSMAXAMMASAMXAXAMXMAXSASMSAAXXAMMSMAMM
XMMSAAMMAXXAMXMMXXXMMAXASXSMSMMMMAXMXAMAMXMXSAMXMAMXAASMXXXAXMAXMMSSSMMXAAAAAMAMAMXMMXMSAXMSAMSMMMSAAAAAMMMAMXAMAXXAMMSMSSMMXSAMMSSSMMXAMASX
MSAMXSAAMMSSXASMMSSSXMSMAAXMAMAAMMMMMSMSXSMXMMMMMAMSXMSAAASXSSMMAMAAMASMMSMMMMXMAMAMAMMSAMXMAXAMSASMSMSSXXMXMMSMSMSSMXAMAAASASMXMXAAAASXSXSM
AMASXMMSXASXSMSAAAASAAAMMMMSASAXXAASAXAMASMSXAXXMAMAMXXMMMXAAAASAMMSMAMAAXXSMASXMMMSMMAMXMASXMAXMAXXMAXAMSSSMAXAAAMAMSMMSSMMXXXXMASMMMSXMAMM
XSXMXAAXMXMAMSSMMMXSMSXSMAAMASAMSSXSAMXMXMASXMMMSMSMASXSXXXMMMMXASXMMXXMMMAAMAMMSAMAAMAMAMXSXMMMSMSMMSMMMAAXMASMMMMMMMAAAAXSMSMXSAMXAXXAMAMM
XMMMSMMSXMSSMAXXXXXXAXMAXMSSMMMMAMAMXMXMSMMMMSSMAXAASAAMSAMXXMXSASAMASXASMMMMXSASASXSSMMSSMMMXSMXAAXAAAXMMSMMASAXXMXMSMMSSMMAAAAMAXSAXSXSMSS
SAAXAMSXMXAMXXSXMMSMMMMSSMMAMXMMXSMMMXXXAAMMAAAXMSSSMSXMASXMASXAXXAMAMXAMAAXMMMAXAMXMAMAMAAXSASMMSMXXSSMXAAMMASAMMMMMAMXAMAMSMSMSMMSMMSAMAAX
SSMSSXSAMMXXAMMAXMAAAXSAAASXMSXSMSAMSAMSSMMMMXSMXAXXAXMXXXMXAAMMSSMMASMMSSMXXAMMMSMMSAMXSSMXMASXAAXSXXMMMMMXMAXXXXAAXAXMMMMXAXAMXAAMAAMAMMMS
MAMAMMSAMSSSMASAMSMSMSAASMMMASASASAMMAXAAXXSMAMXMAMMAMMSMSAMXMAXAAASAXAMXAAASXXAXAAAMASAXMASMAMMSMSAMXAMXMAXMSMMMSSSSSSMMASXMSXSSMMMMMSXMAXX
MSMXXAMAMAAASAMXXXMAMMMMMAXMAMXMAMMMSMMSSMXXMASAXAMSAMXSAMASXSSXSXMMMSXMSMMMAMSMSSSMSXMAMSMSMAMMAMXMASMMSAXSAAAAAMAMAAAMSMSAMAAMAXMASMSMSSMX
MXSSMXMAMMSMMMXSMMSASAAAMXXMASAMXMXAMSAAMAAMMMSAMXXXASAMMSAMMAAAMSXMMAMMXSAXXXAMXAAAAXMSMAXXMSSMXSAXMAAXMAMXMSSMAMAMMMMMAASXMMXSAMMAMAXAAAAS
MSAMXXSASXAMMMXMAXSASMSSSSXSASMSMSMMSMMSXXXAAMXMASMMXMASAMMSMMMAMAXXMASMAMMASMXSMMMMMAMASXSXAMAAMMMMMMSXMXMAXMAMXSASAMASMMMASMASXSSSMMMMSSMS
MMAMAXXAMXXSAMAMSMMMMAMAAAAMXSAAAMSXAXMAMXMMMXAMXMAMAXXMASXSXMMXSMXMAMXMAMXAMAMAMSMXXXSMSXSAMSMMMAAASXXAMMAMXSMMMSMSASASMMSAMMAMMMAAXSAMAAAX
XSSMXSMSMMMSMXSMMXAAMAMMMMMMMMMMXXMMMMXAAAAAMMMXAXAMXMMXAMXMXMAASXSSXSXSXSMXMAAXXAMXMXMXMASMMAAMSMSMSASXMASMMAXXAMASAMMMAAMASMASMMSMMSASMMSM
AMAXMAXAAAAXAAXAMSSSSXSAMXSAAMMSMAMSXMSSSSSXSASAMSASXMSAASAMASMMXAAAASAMXSASXSSSSXXASAMSMMMAMXSMMAXAMAMXMAXAXMSMSMAMAMASMMSAMXASAMXAASMMXMAM
ASAMXMSSSMSMMASAMXXXAAXXMASXXSAASAMAAMXAAAAASAMAMSAMXAMSMSASASAMMSMMMMAXAMSMAMAXXMSMSASAAXSSMMMAMSMMMAMXMASAMXAAAMXMASAXSAMXSMMSAMSMMSSXAAMS
XSXSXXXMXAXMSMSMMSMMMMMSMMSMSMXMSXSSSMMMMMMMMSMXMMSMMMMMXSXMASAMXMASXSXMXSAMMMXMAXAASXMXSMAMAXSAMXMASMSAMXSMMSMSMSSMXMASXXSAMXMSMMSAMXXSXSXA