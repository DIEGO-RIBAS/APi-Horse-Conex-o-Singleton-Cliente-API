unit uModel.Tarefa;

interface
      uses System.JSON, system.SysUtils,
           RESTRequest4D,
           uEntity.Tarefa;

  type
    TModelTarefa = class
      private
        FTarefa : TEntityTarefa;

      public
        property Tarefa : TEntityTarefa read FTarefa write FTarefa;

        function Gravar  : TJSONObject;
        function Deletar : TJSONObject;
        function Alterar : TJSONObject;
        function GetTotalTarefas : TJSONObject;
        function GetTotaltarConcluida7Dias : TJSONObject;
        function Listar  : TJSONObject;

        constructor Create;
        Destructor Destroy;
    end;

implementation

{ TModelUsuario }

function TModelTarefa.Alterar: TJSONObject;
var
  Resp : IResponse;
begin
  Result := TJSONObject.Create;

  try
    Result.AddPair('Id',FTarefa.ID.ToString);
    Result.AddPair('idUsuario',FTarefa.IDUsuario.ToString);
    Result.AddPair('Descricao',FTarefa.Descricao);
    Result.AddPair('DThrLancamento',FTarefa.DThrLancamento);
    Result.AddPair('DThrPrevisaoTermino',FTarefa.DThrPrevisaoTermino);
    Result.AddPair('DThrInicio',FTarefa.DThrInicio);
    Result.AddPair('DThrFinalizada',FTarefa.DThrFinalizada);
    Result.AddPair('Status',FTarefa.Status.ToString);

    Resp := TRequest.New.BaseURL('localhost:9000/')
                                .Resource('AtualizaTarefa')
                                .Accept('application/json')
                                .AddBody(Result.ToString)
                                .Put;
  finally
    Result := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(Resp.Content),0) as TJSONObject;
  end;
end;

constructor TModelTarefa.Create;
begin
  FTarefa := TEntityTarefa.Create;
end;

function TModelTarefa.Deletar: TJSONObject;
var
  Resp : IResponse;
begin
  try
    Resp := TRequest.New.BaseURL('localhost:9000/')
                                .Resource('DeletarTarefa/'+FTarefa.ID.ToString)
                                .Accept('application/json')
                                .Delete;
  finally
    Result := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(Resp.Content),0) as TJSONObject;
  end;
end;

destructor TModelTarefa.Destroy;
begin
  FreeAndNil(FTarefa);
end;

function TModelTarefa.GetTotaltarConcluida7Dias: TJSONObject;
var
  Resp : IResponse;
begin
  try
    Resp := TRequest.New.BaseURL('localhost:9000/')
                                .Resource('TotaltarefasUltimosSeteDias')
                                .Accept('application/json')
                                .Get;
  finally
    Result := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(Resp.Content),0) as TJSONObject;
  end;

end;

function TModelTarefa.GetTotalTarefas: TJSONObject;
var
  Resp : IResponse;
begin
  try
    Resp := TRequest.New.BaseURL('localhost:9000/')
                                .Resource('TotalTarefas')
                                .Accept('application/json')
                                .Get;
  finally
    Result := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(Resp.Content),0) as TJSONObject;
  end;
end;

function TModelTarefa.Gravar: TJSONObject;
var
  Resp : IResponse;
begin
  Result := TJSONObject.Create;

  try
    Result.AddPair('idUsuario',FTarefa.IDUsuario.ToString);
    Result.AddPair('Descricao',FTarefa.Descricao);
    Result.AddPair('DThrLancamento',FTarefa.DThrLancamento);
    Result.AddPair('DThrPrevisaoTermino',FTarefa.DThrPrevisaoTermino);

    Resp := TRequest.New.BaseURL('localhost:9000/')
                                .Resource('GravarTarefa')
                                .Accept('application/json')
                                .AddBody(Result.ToString)
                                .Post;
  finally
    Result := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(Resp.Content),0) as TJSONObject;
  end;
end;

function TModelTarefa.Listar: TJSONObject;
var
  Resp : IResponse;
begin
  try
    Resp := TRequest.New.BaseURL('localhost:9000/')
                                .Resource('ListaTarefas/'+ FTarefa.IDUsuario.ToString)
                                .Accept('application/json')
                                .Get;
  finally
    Result := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(Resp.Content),0) as TJSONObject;
  end;
end;

end.
