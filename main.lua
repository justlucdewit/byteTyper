function love.load()
    love.window.setTitle("byteTyper")

    scripts = 0
    bitcoins = 0
    code = "let foo = \"random generation!!!\";\nfunction foo (){\n\tlet mao = \"stupid af\"\n}"
end

function love.update(dt)
     
end

function love.draw()
    --draw status box
    love.graphics.setColor(0, 1, 0)
    love.graphics.print("scripts:  "..scripts.."kb", 40, 30)
    love.graphics.print("bitcoins: "..bitcoins.."bc", 40, 50)
    love.graphics.rectangle("line", 20, 20, 120, 70)

    --draw IDE
    love.graphics.rectangle("line", 160, 20, love.graphics.getWidth()-180, love.graphics.getHeight()-40)

    --draw game menu
    love.graphics.rectangle("line", 20, 110, 120, love.graphics.getHeight()-130)

    --draw code
    love.graphics.print(code, 180, 40)
end 
