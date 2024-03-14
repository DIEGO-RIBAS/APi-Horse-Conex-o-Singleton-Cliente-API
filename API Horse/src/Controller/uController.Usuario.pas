unit uController.Usuario;

interface

  uses System.SysUtils, System.JSON,System.Classes,
       Horse, Horse.jhonson,

       uModel.Usuario;


  procedure Registry; {=> Pra seguir o padr�o dos controllers e tbm para uma futura implementa��o de melhorias }
  procedure ValidarUsuario(Req: THorseRequest; Res:THorseResponse; Next : TProc );
  procedure AddUsuario(Req: THorseRequest; Res:THorseResponse; Next : TProc );
  procedure ListarUsuarios(Req: THorseRequest; Res:THorseResponse; Next : TProc );

implementation

procedure Registry;
begin
  THorse.Post('Validar',ValidarUsuario);
  THorse.Post('GravarUsuario',AddUsuario);
  THorse.Get('ListarUsuario',ListarUsuarios);
end;

procedure ListarUsuarios(Req: THorseRequest; Res:THorseResponse; Next : TProc );
var
  ModelUsuario : TModelUsuario;
begin
  ModelUsuario := TModelUsuario.Create;

  try
    Res.Send(ModelUsuario.ListarUsuarios).Status(200);
  finally
    FreeAndNil(ModelUsuario);
  end;

end;

procedure AddUsuario(Req: THorseRequest; Res:THorseResponse; Next : TProc );
var
  ModelUsuario : TModelUsuario;
  JSonUsuario  : TJSONObject;
begin
  ModelUsuario := TModelUsuario.Create;
  JSonUsuario  := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(Req.Body),0) as TJSONObject;

  with ModelUsuario do
  begin
    Usuario.Nome   := JSonUsuario.GetValue('Nome').Value;
    Usuario.Longin := JSonUsuario.GetValue('Login').Value;
    Usuario.Pass   := JSonUsuario.GetValue('Pass').Value;
  end;

  try
    Res.Send(ModelUsuario.Gravar).Status(200);
  finally
    FreeAndNil(ModelUsuario);
    FreeAndNil(JSonUsuario);
  end;
end;

procedure ValidarUsuario(Req: THorseRequest; Res:THorseResponse; Next : TProc );
var
  ModelUsuario : TModelUsuario;
  JSonUsuario  : TJSONObject;
begin
  ModelUsuario := TModelUsuario.Create;

  JSonUsuario := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(Req.Body),0) as TJSONObject;

  try
    ModelUsuario.Login := JSonUsuario.GetValue('Login').Value;
    ModelUsuario.Pass  := JSonUsuario.GetValue('Pass').Value;

    try
      Res.Send(ModelUsuario.ValidaUsuario).Status(200);
    finally
      FreeAndNil(ModelUsuario);
    end;

  finally
    FreeAndNil(JSonUsuario);
  end;
end;

end.
