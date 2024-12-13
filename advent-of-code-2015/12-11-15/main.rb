input = "hepxcrrq"

def isValid(password)
  chars = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z)
  containsThree = false
  containsTwoDouble = false
  firstDouble = nil
  for i in 0...(password.length - 1)
    currentLocation = chars.index(password[i])
    if password[i + 2] and password[i + 1] == chars[currentLocation + 1] and password[i + 2] == chars[currentLocation + 2]
      containsThree = true
    end
    if password[i] == password[i + 1] and not firstDouble
      firstDouble = i
    elsif password[i] == password[i + 1] and i > firstDouble + 1
      containsTwoDouble = true
    end
  end
  
  return (containsThree and containsTwoDouble)
  
end

def increment(password)
  chars = %w(a b c d e f g h j k m n p q r s t u v w x y z)
  loc = password.length - 1
  password[loc] = chars[(chars.index(password[loc]) + 1) % chars.length]
  #if ["i", "o", "l"].include? password[loc]
  #  password[loc] = chars[(chars.index(password[loc]) + 1) % 26]
  #end
  while password[loc] == "a"
    password[loc -= 1] = chars[(chars.index(password[loc]) + 1) % chars.length]
  end
  
  return password
end

def getFirstIncrement(password)
  nextChar = {"i" => "j", "o" => "p", "l" => "m"}
  for i in 0...password.length
    if nextChar.keys.include? password[i]
      password[i] = nextChar[password[i]]
      for j in (i + 1)...password.length
        password[j] = "a"
      end
    end
  end
  return password
end

def part1(input)
  password = input.split("")
  password = getFirstIncrement(password)
  while not isValid(password)
    #puts password.join
    password = increment(password)
  end
  return password.join()
end

def part2(input)
  password = part1(input)
  password = increment(password.split(""))
  while not isValid(password)
    #puts password.join
    password = increment(password)
  end
  return password.join()
end

puts part1(input)
puts part2(input)