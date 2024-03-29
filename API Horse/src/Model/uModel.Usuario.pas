unit uModel.Usuario;

interface

uses System.JSON,System.SysUtils, DataSet.Serialize,
        FireDAC.DApt,FireDAC.Stan.Option,FireDAC.Comp.Client,
        FireDAC.Stan.Intf, FireDAC.Phys,
        FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
        FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
        FireDAC.DatS, FireDAC.DApt.Intf,  Data.DB, FireDAC.Comp.DataSet,

    {MyUnits}
    uEntity.Usuario,
    uConexaoSingleton;

   type

    TModelUsuario = class
      private
        FQuery : TFDQuery;

        FPass    : String;
        FLogin   : string;
        FUsuario : TEntityUsuario;
      public
        property Login   : string read FLogin write FLogin;
        property Pass    : String read FPass  write FPass;
        property Usuario : TEntityUsuario read FUsuario write FUsuario;

        function ValidaUsuario : TJSONObject;
        function Gravar : TJSONObject;
        function ListarUsuarios : TJSONObject;

        constructor Create;

        destructor Destroy;
    end;


implementation

{ TUsuario }


{ TModelUsuario }

constructor TModelUsuario.Create;
begin
  FQuery := TFDQuery.Create(nil);

  {Pega conex�o singleton}
  FQuery.Connection := TInstanciaConexao.ObterInstancia.Conexao;

  FUsuario := TEntityUsuario.Create;
end;

destructor TModelUsuario.Destroy;
begin
  FreeAndNil(FQuery);
  FreeAndNil(FUsuario);
end;

function TModelUsuario.Gravar: TJSONObject;
begin
  Result := TJSONObject.Create;

  with FQuery do
  begin
    SQL.Clear;
    SQL.Add('INSERT INTO USUARIO(Nome,Login,Pass) ');
    SQL.Add('VALUES');
    SQL.Add('('''+FUsuario.Nome+''','''+FUsuario.Longin+''', '''+FUsuario.Pass+'''  )');

    try
      ExecSQL;
    Except On E : Exception do
      begin
        { Se houver exce��o armazenamos no Json para ent�o exibir ao usu�rio cliente/api }
        Result.AddPair('Erro','True');
        Result.AddPair('Mensagem', 'SQL: '+ SQL.Text+ ' Except:'+ e.Message);
        raise;
      end;
    end;

    { retorna o ID do Usuario para outros procedimentos }
    if RowsAffected > 0 then
    begin
      Result.AddPair('Erro','False');
      Result.AddPair('Mensagem', 'Tudo OK');

      Close;
    end
      else
      begin
        { Devolve o valor para o cliente/api saber que n�o encontrou }
        Result.AddPair('Erro','False');
        Result.AddPair('Usuario', '0');
      end;
  end;

end;

function TModelUsuario.ListarUsuarios: TJSONObject;
begin
  Result := TJSONObject.Create;

  with FQuery do
  begin
    SQL.Clear;
    SQL.Add('SELECT Id, Nome, Login, Pass FROM USUARIO order by nome ');

    try
      Open();
    Except On E : Exception do
      begin
        { Se houver exce��o armazenamos no Json para ent�o exibir ao usu�rio cliente/api }
        Result.AddPair('Erro','True');
        Result.AddPair('Mensagem', 'SQL: '+ SQL.Text+ ' Except:'+ e.Message);
        raise;
      end;
    end;

    Result.AddPair('Erro','False');
    Result.AddPair('Usuarios', FQuery.ToJSONArray);

    Close;
  end;
end;

function TModelUsuario.ValidaUsuario: TJSONObject;
begin
  Result := TJSONObject.Create;

  with FQuery do
  begin
    SQL.Clear;
    SQL.Add('select ID from USUARIO where Login = '''+FLogin+''' and pass = '''+FPass+''' ');

    try
      Open();
    Except On E : Exception do
      begin
        { Se houver exce��o armazenamos no Json para ent�o exibir ao usu�rio cliente/api }
        Result.AddPair('Erro','True');
        Result.AddPair('Mensagem', 'SQL: '+ SQL.Text+ ' Except:'+ e.Message);
        raise;
      end;
    end;

    { retorna o ID do Usuario para outros procedimentos }
    if RecordCount > 0 then
    begin
      Result.AddPair('Erro','False');
      Result.AddPair('Usuario', FieldByName('id').AsString);

      Close;
    end
      else
      begin
        { Devolve o valor para o cliente/api saber que n�o encontrou }
        Result.AddPair('Erro','False');
        Result.AddPair('Usuario', '0');
      end;
  end;
end;

end.
