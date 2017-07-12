 program backupfb;

uses
  Windows, SysUtils, Classes, Forms,
  UBackup_Restore in 'UBackup_Restore.pas' {FrmBackupRestore};

{$R *.res}



function GetParams: String;
var i, f: integer;
begin
  result:= '';
  f:= ParamCount;
  {se tiver mais de 5 parâmetros, é porque os dois últimos
  são o login e a senha, assim, não deve ser gravado
  no arquivo de log essas duas informações}
  if f > 5 then
     f:= 5;
  for i:= 1 to f do
    result:= result + ParamStr(i) + ' ';
end;

var
  s, log: TStringList;
  pasta_backup, log_file_name: string;
  ext: string[4];
  //h: HWND;
begin
  Application.Initialize;
  Application.HintHidePause := 10000;
  if ParamCount > 0 then
  begin
    s:= TStringList.Create;
    log:= TStringList.Create;
    ext:= '';
    s.clear;
    try
      //tipo_banco = fb10, fb15, ib
      //-b/-c tipo_banco servidor banco pasta_backup [user] [pass]
      //ex: -b fb15 localhost aposentadoria c:\temp\
      if ParamStr(1) = '/?' then
         help_linha_comando
      else if ParamStr(1) = 'login' then
      begin
        //h:= BeginUpdateResource(Application.exe)
        //if ParamStr(2) <> '' then
           //UpdateResource()

        //if ParamStr(3) <> '' then
      end
      else if ParamCount in  [5..7] then
      begin
        Application.Title := 'Backup/Restore FB/IB';
        Application.CreateForm(TFrmBackupRestore, FrmBackupRestore);
        with FrmBackupRestore do
        begin
          if AnsiSameText(ParamStr(1), '-b') then
             rdBackup.Checked := true
          else if AnsiSameText(ParamStr(1), '-c') then
             rdRestore.Checked := true
          else s.add('Parâmetro incorreto: ' + ParamStr(1));

          if AnsiSameText(ParamStr(2), 'fb15') then
          begin
             cmbTipoBanco.ItemIndex := 0;
             ext:= '.fbk';
          end
          else if AnsiSameText(ParamStr(2), 'fb10') then
          begin
            cmbTipoBanco.ItemIndex := 1;
            ext:= '.fbk';
          end
          else if AnsiSameText(ParamStr(2), 'ib') then
          begin
            cmbTipoBanco.ItemIndex := 1;
            ext:= '.gbk';
          end
          else s.add('Parâmetro incorreto: ' +  ParamStr(2));

          lbEdtServidor.Text :=  ParamStr(3);
          if rdBackup.Checked then
          begin
             lbEdtBanco.Text := ParamStr(4);
             pasta_backup := ParamStr(5);

             if (pasta_backup = '') then
                s.add('Informe a pasta de backup')
             else
             begin
                pasta_backup:= IncludeTrailingPathDelimiter(pasta_backup);
                EdtBackup.Text := pasta_backup + 'backup_';
                EdtBackup.Text := EdtBackup.Text + ExtractFileName(lbEdtBanco.Text);
                if ExtractFileExt(EdtBackup.Text) = '' then
                   EdtBackup.Text:= EdtBackup.Text + ext
                else EdtBackup.Text:= ChangeFileExt(EdtBackup.Text, ext);
             end;
          end
          else
          begin
            EdtBackup.Text := ParamStr(4);
            lbEdtBanco.Text:= ParamStr(5);
          end;
          
          EdtBackup.Text:= BackupFileNameDateTime(EdtBackup.Text, 'dd_mm_yyyy_hh_nn_ss"h"');
          if trim(ParamStr(6)) <> '' then
             lbEdtUsuario.Text := ParamStr(6)
          else lbEdtUsuario.Text := usuario;
          if trim(ParamStr(7)) <> '' then
             lbEdtSenha.Text := ParamStr(7)
          else lbEdtSenha.Text := senha;
          //application.MessageBox(pchar('usuario: ' + lbEdtUsuario.Text + ' senha: ' + lbEdtSenha.Text), 'login', MB_ICONINFORMATION);

          if s.Text = '' then
          begin
            btnExecutar.click;
            log.clear;
            log_file_name:= pasta_backup + 'log_backup_fb_ib.txt';
            if FileExists(log_file_name) then
               log.LoadFromFile(log_file_name);
            log.add('Banco de Dados: ' + lbEdtServidor.Text + ':' + lbEdtBanco.Text);
            log.add('Arquivo de Backup: ' + EdtBackup.Text);
            log.add('Comando: ' + ExtractFileName(Application.ExeName) + ' ' + GetParams);
            log.add('Data/Hora: ' + FormatDateTime('dd/mm/yyyy hh:nn:ss',now));
            if rdBackup.Checked then
            begin
              if FileExists(EdtBackup.FileName) then
                 log.add('Status: Backup concluído com sucesso.')
              else log.add('Status: Erro na criação do backup.');
            end
            else
            begin
              if FileExists(lbEdtBanco.Text) then
                 log.add('Status: Restauração concluída com sucesso.')
              else log.add('Status: Erro na restauração do backup.');
            end;
            log.add('-----------------------------------------------------'#13);
            log.SaveToFile(log_file_name);
          end;
        end;
      end
      else s.text:= 'Deve-se informar de 5 a 7 parâmetros. Execute "' + ExtractFileName(Application.ExeName) + ' /?" para ajuda.';

      if s.text <> '' then
         Application.MessageBox(pchar(s.text), 'Erro', MB_ICONERROR)
    finally
      s.free;
      log.free;
    end;
  end
  else
  begin
    Application.CreateForm(TFrmBackupRestore, FrmBackupRestore);
    Application.Run;
  end;
end.
