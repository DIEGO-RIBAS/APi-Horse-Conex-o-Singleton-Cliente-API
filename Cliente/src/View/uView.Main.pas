unit uView.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RESTRequest4D, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ComCtrls, Vcl.ExtCtrls,
  dxGDIPlusClasses, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, FireDAC.Stan.Async,
  FireDAC.DApt, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  Datasnap.DBClient, JvExStdCtrls, JvCombobox, JvDBCombobox, Vcl.Mask,
  System.ImageList, Vcl.ImgList;

type
  TfrmMain = class(TForm)
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    Panel2: TPanel;
    PgCtrl: TPageControl;
    TbsTarefas: TTabSheet;
    TimerLogin: TTimer;
    Panel3: TPanel;
    GroupBox1: TGroupBox;
    Image1: TImage;
    Label1: TLabel;
    Image2: TImage;
    Label2: TLabel;
    Image3: TImage;
    Label3: TLabel;
    GroupBox2: TGroupBox;
    DbgListaTarefas: TDBGrid;
    TabSheet1: TTabSheet;
    Colaboradores: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Image4: TImage;
    Label4: TLabel;
    TimerMsg: TTimer;
    lblMsg: TLabel;
    PageControl1: TPageControl;
    TbsCadColaborador: TTabSheet;
    TbsListaColaboradores: TTabSheet;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    btnInserirColaborador: TSpeedButton;
    edtNome: TEdit;
    edtLogin: TEdit;
    edtPass: TEdit;
    Panel4: TPanel;
    GroupBox4: TGroupBox;
    DgListaColaboradores: TDBGrid;
    GroupBox5: TGroupBox;
    Label8: TLabel;
    btnSelecionarColaboradortarefa: TSpeedButton;
    btnListarusuarios: TSpeedButton;
    DsListaColaboradores: TDataSource;
    CdsListaColaboradores: TClientDataSet;
    CdsListaColaboradoresId: TIntegerField;
    CdsListaColaboradoresNome: TStringField;
    CdsListaColaboradoresLogin: TStringField;
    CdsListaColaboradoresPass: TStringField;
    GroupBox6: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    edtColaboradorTarefa: TJvDBComboBox;
    edtDescrTarefa: TMemo;
    btnAtualizaListaColaboradores: TSpeedButton;
    btnLancarNovaTarefa: TSpeedButton;
    GroupBox7: TGroupBox;
    Label11: TLabel;
    edtDThrPrevisaoTerminotarefa: TMaskEdit;
    Label12: TLabel;
    edtListaColaboradoresTarefa: TJvDBComboBox;
    Label13: TLabel;
    btnUpDateListaColaboradorestarefa: TSpeedButton;
    RadioGroup1: TRadioGroup;
    SpeedButton1: TSpeedButton;
    Panel5: TPanel;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    CdsListaTarefas: TClientDataSet;
    dsListaTarefas: TDataSource;
    CdsListaTarefasDThrLancamento: TStringField;
    CdsListaTarefasDThrPrevisaoTermino: TStringField;
    CdsListaTarefasDThrInicio: TStringField;
    CdsListaTarefasDThrFinalizada: TStringField;
    CdsListaTarefasStatus: TIntegerField;
    CdsListaTarefasDescricao: TStringField;
    CdsListaTarefasid: TIntegerField;
    CdsListaTarefasidUsuario: TIntegerField;
    ImageList: TImageList;
    TabSheet4: TTabSheet;
    GroupBox9: TGroupBox;
    GroupBox10: TGroupBox;
    SpeedButton6: TSpeedButton;
    lbTotaltarefasCluidas7Dias: TLabel;
    btnConsultarTotalTarefas: TSpeedButton;
    lbTotalTarefas: TLabel;
    GroupBox8: TGroupBox;
    mmEstruturabanco: TMemo;
    procedure FormShow(Sender: TObject);
    procedure TimerLoginTimer(Sender: TObject);
    procedure TimerMsgTimer(Sender: TObject);
    procedure btnListarusuariosClick(Sender: TObject);
    procedure DgListaColaboradoresDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnLancarNovaTarefaClick(Sender: TObject);
    procedure btnInserirColaboradorClick(Sender: TObject);
    procedure btnSelecionarColaboradortarefaClick(Sender: TObject);
    procedure edtListaColaboradoresTarefaCloseUp(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure DbgListaTarefasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure btnConsultarTotalTarefasClick(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    idUsuario : Integer;
  end;

var
  frmMain: TfrmMain;

implementation

    uses uView.Login,
         uController.Usuario,
         uEntitity.Usuario,
         uController.Tarefa,
         uEntity.Tarefa;

{$R *.dfm}

procedure TfrmMain.DbgListaTarefasDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
 if State = [] then
  begin
    if CdsListaTarefas.RecNo mod 2 = 1 then
      DbgListaTarefas.Canvas.Brush.Color := clMenu
    else
      DbgListaTarefas.Canvas.Brush.Color := clWhite;
  end;
  DbgListaTarefas.DefaultDrawColumnCell(Rect, DataCol, Column, State);

    { Imagem }
  if Column.FieldName = 'Status' then
  begin
     TDBGrid(Sender).Canvas.FillRect(Rect);
     case CdsListaTarefasStatus.Value of
       0 : ImageList.Draw(TDBGrid(Sender).Canvas, Rect.Left +1,Rect.Top + 1, 0);
       1 : ImageList.Draw(TDBGrid(Sender).Canvas, Rect.Left +1,Rect.Top + 1, 1);
       2 : ImageList.Draw(TDBGrid(Sender).Canvas, Rect.Left +1,Rect.Top + 1, 2);
     end;
  end;
end;

procedure TfrmMain.DgListaColaboradoresDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
 if State = [] then
  begin
    if CdsListaColaboradores.RecNo mod 2 = 1 then
      DgListaColaboradores.Canvas.Brush.Color := clMenu
    else
      DgListaColaboradores.Canvas.Brush.Color := clWhite;
  end;
  DgListaColaboradores.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmMain.edtListaColaboradoresTarefaCloseUp(Sender: TObject);
var
 i : Integer;
begin
  i := edtColaboradorTarefa.Items.IndexOf(edtColaboradorTarefa.Text);

 ShowMessage(   edtColaboradorTarefa.Values.KeyNames[i]);

 ShowMessage(   IntToStr(edtColaboradorTarefa.Values.IndexOfName(Trim(edtColaboradorTarefa.Text))) );
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  idUsuario              := 0;
  PgCtrl.ActivePageIndex := 0;

  btnAtualizaListaColaboradores.OnClick     := btnListarusuarios.OnClick;
  btnUpDateListaColaboradorestarefa.OnClick := btnListarusuarios.OnClick;
end;

procedure TfrmMain.SpeedButton1Click(Sender: TObject);
var
  ControllerTarefa   : TControllerTarefa;
  EntityListaTarefas : TEntityListaTarefas;
  i                  : Integer;
begin
  lblMsg.Caption   := 'Atualizando lista de tarefas';
  lblMsg.Repaint;
  TimerMsg.Enabled := True;

  ControllerTarefa := TControllerTarefa.Create;
  try
    EntityListaTarefas := ControllerTarefa.Listartarefas;
  finally
    FreeAndNil(ControllerTarefa);
  end;

  CdsListaTarefas.Close;
  CdsListaTarefas.CreateDataSet;
  for I := 0 to Pred(EntityListaTarefas.ListaTarefas.Count) do
  begin
    CdsListaTarefas.Append;
    CdsListaTarefas.FieldByName('Id').AsInteger                 := EntityListaTarefas.ListaTarefas[i].ID;
    CdsListaTarefas.FieldByName('Descricao').AsString           := EntityListaTarefas.ListaTarefas[i].Descricao;
    CdsListaTarefas.FieldByName('IDUsuario').AsString           := EntityListaTarefas.ListaTarefas[i].IDUsuario.ToString;
    CdsListaTarefas.FieldByName('DThrLancamento').AsString      := EntityListaTarefas.ListaTarefas[i].DThrLancamento;
    CdsListaTarefas.FieldByName('DThrPrevisaoTermino').AsString := EntityListaTarefas.ListaTarefas[i].DThrPrevisaoTermino;
    CdsListaTarefas.FieldByName('DThrInicio').AsString          := EntityListaTarefas.ListaTarefas[i].DThrInicio;
    CdsListaTarefas.FieldByName('DThrFinalizada').AsString      := EntityListaTarefas.ListaTarefas[i].DThrFinalizada;
    CdsListaTarefas.FieldByName('Status').AsString              := EntityListaTarefas.ListaTarefas[i].Status.ToString;
    CdsListaTarefas.Post;
  end;
end;

procedure TfrmMain.SpeedButton2Click(Sender: TObject);
var
  ControllerTarefa : TControllerTarefa;
begin
  if CdsListaTarefas.IsEmpty then
  begin
    Application.MessageBox('N�o h� tarefa a ser finalizada.','Aten��o !',MB_ICONMASK);
    Exit;
  end;

  if CdsListaTarefasStatus.Value = 2 then
  begin
    Application.MessageBox('Tarefa j� finalizada "','Aten��o !',MB_ICONMASK);
  end;

  if Application.MessageBox('Deseja realmente finalizar a tarefa ?','Confirma��o !',MB_ICONWARNING + mb_yesno) = ID_NO then
    Exit;

  ControllerTarefa := TControllerTarefa.Create;
  try
    with ControllerTarefa do
    begin
      Tarefa.ID                  := CdsListaTarefasid.AsInteger;
      Tarefa.Descricao           := CdsListaTarefasDescricao.AsString;
      Tarefa.IDUsuario           := idUsuario;
      Tarefa.DThrLancamento      := CdsListaTarefasDThrLancamento.AsString;
      Tarefa.DThrPrevisaoTermino := CdsListaTarefasDThrPrevisaoTermino.AsString;
      Tarefa.DThrInicio          := CdsListaTarefasDThrInicio.AsString;
      Tarefa.DThrFinalizada      := CdsListaTarefasDThrFinalizada.AsString;
      Tarefa.Status := 2;
    end;

    if ControllerTarefa.Alterar then
    begin
      lblMsg.Caption   := 'Altera��o realizada com sucesso';
      TimerMsg.Enabled := True;
    end;
  finally
    FreeAndNil(ControllerTarefa);

    CdsListaTarefas.Edit;
    CdsListaTarefasStatus.Value := 2;
    CdsListaTarefas.Post;
  end;

end;

procedure TfrmMain.SpeedButton4Click(Sender: TObject);
var
  ControllerTarefa : TControllerTarefa;
begin
  if CdsListaTarefas.IsEmpty then
  begin
    Application.MessageBox('','Aten��o !',MB_ICONMASK);
    Exit;
  end;

  if Application.MessageBox('Deseja realmente excluir a tarefa ?','Confirma��o !',MB_ICONQUESTION + mb_yesno) = ID_NO then
    Exit;

  ControllerTarefa := TControllerTarefa.Create;
  try
    with ControllerTarefa do
    begin
      Tarefa.ID := CdsListaTarefasid.AsInteger;
    end;

    if ControllerTarefa.Deletar then
    begin
      lblMsg.Caption   := 'Exclus�o realizada com sucesso';
      TimerMsg.Enabled := True;
    end;
  finally
    FreeAndNil(ControllerTarefa);

    CdsListaTarefas.Delete;
  end;
end;

procedure TfrmMain.SpeedButton6Click(Sender: TObject);
var
  ControllerTarefas : TControllerTarefa;
  iTotaltarefas     : Integer;
begin
  lblMsg.Caption   := 'Consultando total de tarefas conclu�das nos �ltimos 7 dias ... aguarde';
  lblMsg.Repaint;
  TimerMsg.Enabled := True;

  ControllerTarefas := TControllerTarefa.Create;
  try
    iTotaltarefas := ControllerTarefas.GetTotalTarefaConcluidas7Dias;
  finally
    FreeAndNil(ControllerTarefas);
  end;

  lbTotaltarefasCluidas7Dias.Caption := 'Total de tarefas conclu�das nos ultimos 7 dias :' + IntToStr(iTotaltarefas);
end;

procedure TfrmMain.btnConsultarTotalTarefasClick(Sender: TObject);
var
  ControllerTarefas : TControllerTarefa;
  iTotaltarefas     : Integer;
begin
  lblMsg.Caption   := 'Consultando total de tarefas ... aguarde';
  lblMsg.Repaint;
  TimerMsg.Enabled := True;

  ControllerTarefas := TControllerTarefa.Create;
  try
    iTotaltarefas := ControllerTarefas.GetTotalTarefa;
  finally
    FreeAndNil(ControllerTarefas);
  end;

  lbTotalTarefas.Caption := 'Total de tarefas  :' + IntToStr(iTotaltarefas);
end;

procedure TfrmMain.btnInserirColaboradorClick(Sender: TObject);
var
  ControllerUsuario : TControllerUsuario;
begin
  ControllerUsuario := TControllerUsuario.Create;
  try
    with ControllerUsuario do
    begin
      EntityUsuario.Nome   := edtNome.Text;
      EntityUsuario.Longin := edtLogin.Text;
      EntityUsuario.Pass   := edtPass.Text;
    end;

    if ControllerUsuario.Gravausuario(ControllerUsuario.EntityUsuario)then
    begin
      lblMsg.Caption   := 'Colaborador inserido com sucesso.';
      lblMsg.Repaint;
      TimerMsg.Enabled := True;

      edtNome.Clear;
      edtLogin.Clear;
      edtPass.Clear;
    end;

  finally
    FreeAndNil(ControllerUsuario);
  end;
end;

procedure TfrmMain.btnLancarNovaTarefaClick(Sender: TObject);
var
  ControllerTarefa : TControllerTarefa;
begin
  ControllerTarefa := TControllerTarefa.Create;
  try
    with ControllerTarefa do
    begin
      Tarefa.IDUsuario           := idUsuario;
      Tarefa.Descricao           := edtDescrTarefa.Text;
      Tarefa.DThrLancamento      := DateTimeToStr(Now);
      Tarefa.DThrPrevisaoTermino := edtDThrPrevisaoTerminotarefa.Text;
      Tarefa.Status              := 0; { 0 = Aguardando  1 = Em desenvolvimento  2 = Finalizada }
    end;

    if ControllerTarefa.Gravar then
    begin
      lblMsg.Caption   := 'Lan�amento realizado com sucesso';
      lblMsg.Repaint;
      TimerMsg.Enabled := True;

      edtColaboradorTarefa.Items.Clear;
      edtDThrPrevisaoTerminotarefa.Clear;
      edtDescrTarefa.Clear;
    end;
  finally
    FreeAndNil(ControllerTarefa);
  end;
end;

procedure TfrmMain.btnListarusuariosClick(Sender: TObject);
var
  ControllerUsuario : TControllerUsuario;
  ListaUsuarios     : TEntityListaUsuarios;
  i                 : Integer;
begin
  lblMsg.Caption   := 'Atualizando lista ... aguarde';
  lblMsg.Repaint;
  TimerMsg.Enabled := True;

  ControllerUsuario := TControllerUsuario.Create;
  try
    ListaUsuarios := ControllerUsuario.ListarUsuarios;
  finally
    FreeAndNil(ControllerUsuario);
  end;

  { Combobox da aba nova tarefa }
  edtColaboradorTarefa.Clear;

  { Lista de colaboradores - pode escolher um para ent�o lan�ar uma tarefa  }
  CdsListaColaboradores.Close;
  CdsListaColaboradores.CreateDataSet;
  for I := 0 to Pred(ListaUsuarios.Listausuario.Count) do
  begin
    CdsListaColaboradores.Append;
    CdsListaColaboradores.FieldByName('Id').AsInteger    := ListaUsuarios.Listausuario[i].ID;
    CdsListaColaboradores.FieldByName('Nome').AsString   := ListaUsuarios.Listausuario[i].Nome;
    CdsListaColaboradores.FieldByName('Login').AsString  := ListaUsuarios.Listausuario[i].Longin;
    CdsListaColaboradores.FieldByName('Pass').AsString   := ListaUsuarios.Listausuario[i].Pass;
    CdsListaColaboradores.Post;

    { Combobox }
    edtColaboradorTarefa.Values.Add(ListaUsuarios.Listausuario[i].ID.ToString);
    edtColaboradorTarefa.Items.Add(ListaUsuarios.Listausuario[i].Nome);

    edtListaColaboradoresTarefa.Values.Add(ListaUsuarios.Listausuario[i].ID.ToString);
    edtListaColaboradoresTarefa.Items.Add(ListaUsuarios.Listausuario[i].Nome);
  end;
end;

procedure TfrmMain.btnSelecionarColaboradortarefaClick(Sender: TObject);
begin
  if CdsListaColaboradores.IsEmpty then
  begin
    lblMsg.Caption   := 'N�o h� colaborador a ser selecionado';
    lblMsg.Repaint;
    TimerMsg.Enabled := True;
    Exit;
  end;

  edtColaboradorTarefa.ItemIndex := edtColaboradorTarefa.Items.IndexOf(CdsListaColaboradoresNome.AsString);
  PgCtrl.ActivePageIndex := 1;
end;

procedure TfrmMain.TimerLoginTimer(Sender: TObject);
begin
  TimerLogin.Enabled := False;
  try
    Application.CreateForm(TfrmLogin, frmLogin);
    frmLogin.ShowModal;
  finally
    idUsuario := frmLogin.idUsuario;
    FreeAndNil(frmLogin);

    lblMsg.Caption   := 'Seja bem vindo';
    lblMsg.Repaint;
    TimerMsg.Enabled := True;
  end;
end;

procedure TfrmMain.TimerMsgTimer(Sender: TObject);
begin
  TimerMsg.Enabled := false;
  lblMsg.Caption   := '';
end;

end.
