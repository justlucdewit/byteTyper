local codeGen = {}

function codeGen.generate(linesAllowed)
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

function getRandom(arr)
    return arr[math.random(#arr)]
end

function numOfLines(str)
    local _, count = str:gsub("\n", "\n")
    return count+1
end

return codeGen