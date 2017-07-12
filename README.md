# Delphi Firebird Backup [![GPL licensed](https://img.shields.io/badge/license-GPL-blue.svg)](http://www.gnu.org/licenses/gpl-3.0)

Aplicação de Backup/Restore de Bancos de [Firebird](http://firebirdsql.org), desenvolvida em Delphi XE 1.

A aplicação pode ser executada via linha de comando, para permitir a automatização do backup/restore.
Quando executada normalmente, um botão na interface mostra os parâmetros disponíveis.
Ajuda pode ser obtida via linha de comando executando `backupfb /?`.
Desta forma, é possível incluir a aplicação como uma tarefa no Agendador de Tarefas do Windows.
O arquivo [agendar-backup.bat](agendar-backup.bat) mostra um exemplo de comando para fazer isso.

Utilizando o comando exemplificado, pode-se, por exemplo, utilizar o [Inno Setup](http://www.jrsoftware.org/isinfo.php) 
para instalar uma determinada aplicação que use um banco de dados Firebird e então executar
a linha de comando mostrada no bat para agendar o backup.

# Componentes Utilizados

- [Biblioteca JVCL 3.4](http://jvcl.delphi-jedi.org)
- [Biblioteca UIB para Backup e Restore de Bancos Firebird](https://github.com/hgourvest/uib)
