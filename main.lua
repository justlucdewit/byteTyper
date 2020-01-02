function love.load()
    math.randomseed(os.time())
    math.random();math.random();math.random();math.random();math.random()

    love.window.setTitle("byteTyper")

    scripts = 0
    bitcoins = 0
    bitcoinworth = math.random(0.8, 1.2)
    code = generateCode(45)
    userinput = ""
    charsTyped = 1
    line = 0
    col = 0
    
    isInMenu = true
    menupos = 1

end

function love.update(dt)
    if charsTyped == #code-1 then
        --completed the script
        userinput = ""
        code = generateCode(45)
        charsTyped = 1
    end
end

function love.keypressed(key)
    if not isInMenu then--IDE controlls
        if key == "return" and string.sub(code, charsTyped, charsTyped) == "\n" then
            userinput=userinput.."\n"
            charsTyped=charsTyped+1
            scripts=scripts+0.001
            col = 0
            line=line+1
        elseif key == "tab" and string.sub(code, charsTyped, charsTyped) == "\t" then
            userinput=userinput.."\t"
            charsTyped=charsTyped+1
            scripts=scripts+0.001
            col=col+1
        elseif key == "escape" then
            isInMenu = true
            menupos = 1
        end
    else--menu controlls
        if key == "return" then
            if menupos == 1 then
                isInMenu = false
                menupos = -1
            elseif menupos == 2 then
                bitcoins = bitcoins+ scripts*bitcoinworth
                scripts = 0
                bitcoinworth = math.random(0.8, 1.2)
            end
        elseif key == "up" then
            menupos = menupos - 1
            if menupos < 1 then
                menupos = 1
            end
        elseif key == "down" then
            menupos = menupos + 1
            if menupos > 5 then
                menupos = 5
            end
        end
    end
end

function love.textinput(key)
    if not isInMenu then
        if key == string.sub(code, charsTyped, charsTyped) then
            userinput=userinput..key
            charsTyped=charsTyped+1
            scripts=scripts+0.001
            col = col+1
        end
    end
end

function love.draw()
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()

    --draw status box
    love.graphics.setColor(0, 1, 0)
    love.graphics.print("scripts:  "..scripts.."kb", 40, 30)
    love.graphics.print("bitcoins: "..bitcoins.."bc", 40, 50)
    love.graphics.rectangle("line", 20, 20, 130, 70)

    --draw IDE
    love.graphics.rectangle("line", 160, 20, width-180, height-80)

    --draw game menu
    love.graphics.rectangle("line", 20, 110, 130, height-170)
    
    setMenuColor(1)
    love.graphics.print("edit", 40, 130)
    
    setMenuColor(2)
    love.graphics.print("sell", 40, 150)

    setMenuColor(3)
    love.graphics.print("shop", 40, 170)

    setMenuColor(4)
    love.graphics.print("save", 40, 190)

    setMenuColor(5)
    love.graphics.print("exit", 40, 210)

    --draw code
    love.graphics.setColor(0, 0.2, 0)
    love.graphics.print(code, 180, 40)
    
    --draw already written code
    love.graphics.setColor(0, 1, 0)
    if os.time()%2 == 0 then
        love.graphics.print(userinput, 180, 40)
    else
        love.graphics.print(userinput.."_", 180, 40)
    end

    --draw status bar
    love.graphics.rectangle("line", 20, height-50, width-40, 40)
    love.graphics.print(os.date("%H:%M:%S %d-%m-%Y"), 30, height-40)--time
    love.graphics.print("Ln "..line..", Col, "..col, width-120, height-40)--cursor location
end 

function generateCode(linesAllowed)
    local linesGenerated = 0
    local variableNames = {"foo", "bar", "i", "n", "num", "x", "y", "dt", "delta", "arr", "placeHolder", "a", "b", "j", "k", "l", "z", "depth", "length", "empty", "score", "itterations"}
    local functionNames = {"func", "encrypt", "decrypt", "generate", "applyAlg", "crash", "hack", "connect"}
    local strings = {"default", "score: %d", "line", "232.255.114.240", "localhost", "wifi", "cracked", "title", "connected..."}

    local retcode = ""

    while true do
            local codeSegments = {string.format("let %s = %d;", getRandom(variableNames), math.random(1000)), 
                    string.format("let %s = \"%s\";", getRandom(variableNames), getRandom(strings)),
                    string.format("console.log(%s);", getRandom(variableNames)),
                    string.format("console.log(\"%s\");", getRandom(strings)),
                    string.format("function %s(%s, %s){\n\treturn %s+%s/2;\n}", getRandom(functionNames), getRandom(variableNames), getRandom(variableNames), getRandom(variableNames), getRandom(variableNames))
                }

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

function setMenuColor(n)
    if n == menupos then
        love.graphics.setColor(0, 1, 0)
    else
        love.graphics.setColor(0, 0.2, 0)
    end
end

function getRandom(arr)
    return arr[math.random(#arr)]
end