function love.load()
    math.randomseed(os.time())
    math.random();math.random();math.random();math.random();math.random()

    love.window.setTitle("byteTyper")

    scripts = 0
    bitcoins = 0
    code = generateCode(45)
    userinput = ""
    charsTyped = 1
    lastkey = ""
end

function love.update(dt)

end

function love.keypressed(key)
    lastkey = key
    
    if key == "return" then
        key = "\n"
    elseif key == "space" then
        key = " "
    end

    if key == string.sub(code, charsTyped, charsTyped) then
        userinput=userinput..key
        charsTyped=charsTyped+1
        scripts=scripts+0.001
    end

end

function love.draw()
    --draw status box
    love.graphics.setColor(0, 1, 0)
    love.graphics.print("scripts:  "..scripts.."kb", 40, 30)
    love.graphics.print("bitcoins: "..bitcoins.."bc", 40, 50)
    love.graphics.rectangle("line", 20, 20, 130, 70)

    --draw IDE
    love.graphics.rectangle("line", 160, 20, love.graphics.getWidth()-180, love.graphics.getHeight()-40)

    --draw game menu
    love.graphics.rectangle("line", 20, 110, 130, love.graphics.getHeight()-130)
    love.graphics.print("last key: "..lastkey, 40, 120)

    --draw code
    love.graphics.setColor(0, 0.2, 0)
    love.graphics.print(code, 180, 40)
    
    --draw already written code
    love.graphics.setColor(0, 1, 0)
    love.graphics.print(userinput, 180, 40)
end 

function generateCode(linesAllowed)
    local linesGenerated = 0
    local variableNames = {"foo", "bar", "i", "n", "num", "x", "y", "dt", "delta", "arr", "placeHolder", "a", "b", "j", "k", "l", "z", "depth", "length", "empty", "score", "itterations"}
    local functionNames = {"func", "encrypt", "decrypt", "generate", "applyAlg", "crash", "hack", "connect"}
    local strings = {"default", "score: %d", "line", "232.255.114.240", "localhost", "wifi", "cracked", "title", "connected..."}

    local codeSegments = {string.format("let %s = %d;", getRandom(variableNames), math.random(1000)), 
                    string.format("let %s = \"%s\";", getRandom(variableNames), getRandom(strings)),
                    string.format("console.log(%s);", getRandom(variableNames)),
                    string.format("console.log(\"%s\");", getRandom(strings)),
                    string.format("function %s(%s, %s){\n\treturn %s+%s/2;\n}", getRandom(functionNames), getRandom(variableNames), getRandom(variableNames), getRandom(variableNames), getRandom(variableNames))
                }
    local retcode = ""

    while true do
        local newsegment = getRandom(codeSegments)
        newsegment = newsegment.."\n\n"
        if linesGenerated+numOfLines(newsegment) > linesAllowed then
            break
        end

        linesGenerated = linesGenerated + numOfLines(newsegment)
        retcode = retcode..newsegment
    end
    return retcode
end

function numOfLines(str)
    local _, count = str:gsub("\n", "\n")
    return count+1
end

function getRandom(arr)
    return arr[math.random(#arr)]
end