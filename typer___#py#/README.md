# 用 typer 库实现多层次命令

用 typer 库可以很方便地实现 CLI 程序，支持单命令 `single.py [OPTIONS] [ARGS]` 和多命令 `multi.py [OPTIONS] COMMAND [ARGS]`。

同时，typer 库本身支持多层次命令，只需将子命令的 Typer 对象加入父命令的 Typer 对象。

如果子命令是单命令时，理想的 CLI 调用形式应该如：`multi.py single ARGS`，但是，直接将子命令的 Typer 对象加入会导致调用形式必须为：`multi.py single funcname ARGS`，其中 `single` 是 `add_typer` 时的 `name` 参数，`funcname` 是原本子命令的函数名。

为解决这个问题，在添加子命令时，需要判断子命令中的 `command` 个数，如果只有1个，那就直接把这个 command 加进来，而不是把子命令的 Typer 加进来。

### 示例代码：
```python
if len(sub.app.registered_commands) == 1:
    app.command('sub')(sub.app.registered_commands[0].callback)
else:
    app.add_typer(sub.app, name='sub')
```