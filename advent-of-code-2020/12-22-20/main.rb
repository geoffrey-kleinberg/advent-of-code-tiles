p1 = []
p2 = []
File.open("input.txt") do |f|
	first = true
	f.each do |i|
		next if i == "Player 1:\n" or i == "\n"
		if not first
			p2 << i.strip.to_i
		end
		if i == "Player 2:\n"
			first = false
		end
		if first
			p1 << i.strip.to_i
		end
	end
end
def part1(p1, p2)
	while p1.length > 0 and p2.length > 0
		p1Curr = p1[0]
		p2Curr = p2[0]
		if p1Curr > p2Curr
			p1 << p1Curr
			p1 << p2Curr
		else
			p2 << p2Curr
			p2 << p1Curr
		end
		p1.delete_at(0)
		p2.delete_at(0)
	end
	val = 0
	if p1.length == 0
		puts 2
		p2.each.with_index do |i, ind|
			val += i * (p2.length - ind)
		end
	else
		puts 1
		p1.each.with_index do |i, ind|
			val += i * (p1.length - ind)
		end
	end
	return val
end
def recursiveCombat(p1, p2, oL)
	prevP1s = [p1.clone]
	while p1.length > 0 and p2.length > 0
		p1Curr = p1[0]
		p2Curr = p2[0]
		if p1Curr < p1.length and p2Curr < p2.length
			winner = recursiveCombat(p1.slice(1, p1Curr), p2.slice(1, p2Curr), oL)
			if winner == 1
				p1 << p1Curr
				p1 << p2Curr
			else
				p2 << p2Curr
				p2 << p1Curr
			end
		else
			if p1Curr > p2Curr
				p1 << p1Curr
				p1 << p2Curr
			else
				p2 << p2Curr
				p2 << p1Curr
			end
		end
		p1.delete_at(0)
		p2.delete_at(0)
		if prevP1s.include? p1
			return 1
		end
		prevP1s << p1.clone
	end
	if p1.length == 0
		yield p1, p2 if p2.length == oL
		return 2
	else
		yield p1, p2 if p1.length == oL
		return 1
	end
end
def part2(p1, p2)
	winner = recursiveCombat(p1, p2, p1.length + p2.length) do |i, j|
		p1 = i.clone
		p2 = j.clone
	end
	val = 0
	if winner == 1
		p1.each.with_index do |i, ind|
			val += i * (p1.length - ind)
		end
	else
		p2.each.with_index do |i, ind|
			val += i * (p2.length - ind)
		end
	end
	puts winner
	return val
end
t = Time.now
puts part1(p1.clone, p2.clone)
puts Time.now - t
t = Time.now
puts part2(p1.clone, p2.clone)
puts Time.now - t