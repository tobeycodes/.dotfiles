rex.bind("ctrl+b>shift+n", "session.new")
rex.bind("ctrl+b>shift+w", "session.rename")
rex.bind("ctrl+b>shift+d", "session.close")

rex.bind("ctrl+b>c", "client.tab.new")
rex.bind("ctrl+b>p", "client.tab.previous")
rex.bind("ctrl+b>n", "client.tab.next")
rex.bind("ctrl+b>shift+t", "client.tab.rename")
rex.bind("ctrl+b>shift+x", "client.tab.close")

rex.bind("ctrl+b>h", "pane.focus.left")
rex.bind("ctrl+b>j", "pane.focus.down")
rex.bind("ctrl+b>k", "pane.focus.up")
rex.bind("ctrl+b>l", "pane.focus.right")
rex.bind("ctrl+b>tab", "pane.focus_next")
rex.bind("ctrl+b>shift+tab", "pane.focus_previous")

rex.bind("ctrl+b>v", "pane.split.right")
rex.bind("ctrl+b>-", "pane.split.down")
rex.bind("ctrl+b>shift+p", "pane.rename")
rex.bind("ctrl+b>x", "pane.close")
rex.bind("ctrl+b>z", "pane.zoom")

rex.bind("ctrl+b>b", "client.sidebar.toggle")
rex.bind("ctrl+b>a", "client.sidebar.activity.toggle")
rex.bind("ctrl+b>g", "client.palette.toggle")
rex.bind("ctrl+b>s", "client.settings")
rex.bind("ctrl+b>shift+r", "client.config.reload")

rex.mode("resize", { exclusive = true })
rex.bind("ctrl+b>r", "client.mode.enter", { name = "resize" })
for key, direction in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
    rex.bind("resize/" .. key, "pane.resize", { direction = direction })
    rex.bind("resize/" .. direction, "pane.resize", { direction = direction })
end
rex.bind("resize/enter", "client.mode.exit")

for index = 1, 9 do
    local action = "select_session_" .. index
    rex.action{
        name = action,
        title = "Select session " .. index,
        run = function()
            local list = assert(rex.call("session.list", {}))
            local session = list.sessions[index]
            if session then
                rex.client.queue("session.select", { session_id = session.session_id })
            end
        end,
    }
    rex.bind("ctrl+b>w>" .. index, action)
end

for index = 1, 9 do
    local action = "current_session_tab_" .. index
    rex.action{
        name = action,
        title = "Select tab " .. index .. " in the current session",
        run = function(ctx)
            if not ctx.session_id then return end
            local view = assert(rex.session.view{ session_id = ctx.session_id })
            local tab = view.windows[index]
            if tab then
                rex.client.queue("session.select", {
                    session_id = ctx.session_id,
                    window_id = tab.window_id,
                })
            end
        end,
    }
    rex.bind("ctrl+b>" .. index, action)
end
