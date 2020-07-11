import typer
import sub, sub2

app = typer.Typer()

@app.command()
def main(arg: str):
    typer.echo(f'main(arg={arg})')

if __name__ == "__main__":
    if len(sub.app.registered_commands) == 1:
        app.command('sub')(sub.app.registered_commands[0].callback)
    else:
        app.add_typer(sub.app, name='sub')
    if len(sub2.app.registered_commands) == 1:
        app.command('sub2')(sub2.app.registered_commands[0].callback)
    else:
        app.add_typer(sub2.app, name='sub2')
    app()
