# �� typer ��ʵ�ֶ�������

�� typer ����Ժܷ����ʵ�� CLI ����֧�ֵ����� `single.py [OPTIONS] [ARGS]` �Ͷ����� `multi.py [OPTIONS] COMMAND [ARGS]`��

ͬʱ��typer �Ȿ��֧�ֶ������ֻ�轫������� Typer ������븸����� Typer ����

����������ǵ�����ʱ������� CLI ������ʽӦ���磺`multi.py single ARGS`�����ǣ�ֱ�ӽ�������� Typer �������ᵼ�µ�����ʽ����Ϊ��`multi.py single funcname ARGS`������ `single` �� `add_typer` ʱ�� `name` ������`funcname` ��ԭ��������ĺ�������

Ϊ���������⣬�����������ʱ����Ҫ�ж��������е� `command` ���������ֻ��1�����Ǿ�ֱ�Ӱ���� command �ӽ����������ǰ�������� Typer �ӽ�����

### ʾ�����룺
```python
if len(sub.app.registered_commands) == 1:
    app.command('sub')(sub.app.registered_commands[0].callback)
else:
    app.add_typer(sub.app, name='sub')
```