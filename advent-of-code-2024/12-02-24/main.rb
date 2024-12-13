day = "02"
file_name = "12-#{day}-24/sampleIn.txt"
file_name = "12-#{day}-24/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    count = 0
    for r in input
      nums = r.split(" ").map { |i| i.to_i }
      if nums == nums.sort or nums == nums.sort.reverse
        all_good = true
        for i in 0...(nums.length - 1)
          delta = (nums[i + 1] - nums[i]).abs
          if delta > 3 or delta == 0
            all_good = false
          end
        end
        if all_good
          count += 1
        end
      end
    end
    return count
end

def part2(input)
    count = 0
    for r in input
        nums_original = r.split(" ").map { |i| i.to_i }
        any_good = false
        for remove in 0...(nums_original.length)
            nums = nums_original.clone
            nums.delete_at(remove)
            if nums == nums.sort or nums == nums.sort.reverse
                all_good = true
                for i in 0...(nums.length - 1)
                    delta = (nums[i + 1] - nums[i]).abs
                    if delta > 3 or delta == 0
                        all_good = false
                    end
                    break if not all_good
                end
                if all_good
                    any_good = true
                end
                break if any_good
            end
        end
        if any_good
            count += 1
        end
    end
    return count
end

# puts part1(data)
puts part2(data)