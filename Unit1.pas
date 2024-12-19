unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, CommCtrl,
  TlHelp32, acPNG, Vcl.ExtCtrls, Vcl.Buttons, Vcl.ImgList, acAlphaImageList,
  sSpeedButton, Vcl.ComCtrls, sGroupBox, sSkinManager, sRadioButton, sCheckBox;

type
  TForm1 = class(TForm)
    sAlphaImageList1: TsAlphaImageList;
    StatusBar1: TStatusBar;
    sGroupBox1: TsGroupBox;
    Image1: TImage;
    Image2: TImage;
    sSpeedButton1: TsSpeedButton;
    sSpeedButton2: TsSpeedButton;
    sSpeedButton3: TsSpeedButton;
    Edit3: TEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    sSkinManager1: TsSkinManager;
    Image3: TImage;
    Image4: TImage;
    sCheckBox1: TsCheckBox;
    sCheckBox2: TsCheckBox;
    sRadioButton1: TsRadioButton;
    sRadioButton2: TsRadioButton;
    Edit9: TEdit;
    Edit10: TEdit;
    sSpeedButton4: TsSpeedButton;
    procedure sSpeedButton1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sSpeedButton1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sSpeedButton2Click(Sender: TObject);
    procedure sSpeedButton3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sSpeedButton3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure sCheckBox1Click(Sender: TObject);
    procedure sCheckBox2Click(Sender: TObject);
    procedure sSpeedButton4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sSpeedButton4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

type
  TUInt = {$IFDEF WIN64}UInt64{$ELSE}UInt32{$ENDIF};

implementation

{$R *.dfm}


procedure SimulateClickWithSendInput(X, Y: Integer);
var
  Input: array[0..2] of TInput;
begin
  ZeroMemory(@Input, SizeOf(Input));
  Input[0].Itype := INPUT_MOUSE;
  Input[0].mi.dwFlags := MOUSEEVENTF_MOVE or MOUSEEVENTF_ABSOLUTE;
  Input[0].mi.dx := X * 65535 div Screen.Width;
  Input[0].mi.dy := Y * 65535 div Screen.Height;
  Input[1].Itype := INPUT_MOUSE;
  Input[1].mi.dwFlags := MOUSEEVENTF_LEFTDOWN;
  Input[2].Itype := INPUT_MOUSE;
  Input[2].mi.dwFlags := MOUSEEVENTF_LEFTUP;
  SendInput(3, Input[0], SizeOf(TInput));
end;

procedure MinimizeClientRMS;
var
 H: HWND;
begin
  try
    H := FindWindow('TfmMain', 'Viewer');
    if H <> 0 then ShowWindow(H, SW_MINIMIZE);
    if H = 0 then
    begin
      H := FindWindow('TfmMain', 'Viewer- Клиент');
      if H <> 0 then ShowWindow(H, SW_MINIMIZE);
    end;
  except
    ;
  end;
  sleep(500);
end;

procedure MinimizeServerRMS;
var
 J: HWND;
begin
  try
    J := FindWindow('TfmMain', 'Remote Utilities Server [local server]');
    if J <> 0 then ShowWindow(J, SW_MINIMIZE);
    if J = 0 then
    begin
      J := FindWindow('TfmMain', 'Mini Internet-ID сервер [локальный сервер]');
      if J <> 0 then ShowWindow(J, SW_MINIMIZE);
    end;
  except
    ;
  end;
  sleep(500);
end;

procedure VKPost(H: HWND; I: TUInt);
begin
  PostMessage(H, WM_KEYDOWN, I, 0);
  PostMessage(H, WM_KEYUP, I, 0);
  sleep(100);
end;

procedure LBPost(H: HWND);
begin
  PostMessage(H, WM_LButtonDown, 0, 0);
  PostMessage(H, WM_LButtonUP, 0, 0);
  sleep(500);
end;

procedure FindWindowRMS;
var
  H,J:HWND;
begin
  if Form1.sCheckBox1.Checked = True then
  begin
    H := FindWindow('TfmMain', 'Mini Internet-ID сервер [локальный сервер]');
    J := FindWindow('TfmMain', 'Remote Utilities Server [local server]');
    if H <> 0 then  Form1.sRadioButton1.Checked := True;
    if J <> 0 then  Form1.sRadioButton2.Checked := True;
  end;
  if Form1.sCheckBox2.Checked = True then
  begin
    H := FindWindow('TfmMain', 'Viewer- Клиент');
    J := FindWindow('TfmMain', 'Viewer');
    if H <> 0 then  Form1.sRadioButton1.Checked := True;
    if J <> 0 then  Form1.sRadioButton2.Checked := True;
  end;
  Application.ProcessMessages;
end;

procedure ClickTCheckBoxСheck(H:HWND);
var
  CS: integer;
begin
  CS := SendMessage(H, BM_GETCHECK, 0, 0);
  if CS = 0 then
  begin
    SendMessage(H, BM_SETSTATE, 0, 0);
    SendMessage(H, BM_CLICK, 0, 0);
  end;
end;

procedure ClickTCheckBoxUncheck(H:HWND);
var
  CS: integer;
begin
  CS := SendMessage(H, BM_GETCHECK, 0, 0);
  if CS <> 0 then
  begin
    SendMessage(H, BM_SETSTATE, 0, 0);
    SendMessage(H, BM_CLICK, 0, 0);
  end;
end;

function MenuClickButton(SClass, SWindow: PWideChar; I, J: integer): Boolean;
var
  H, H2, H3, H4: HWND;
begin
  try
    H := FindWindow(SClass, SWindow);
    H2 := GetMenu(H);
    H3:=GetSubMenu(H2, I);
    H4:=GetMenuItemID(H3, J);
    Result := PostMessage(H,WM_COMMAND,H4,0);
  except
    Result := False;
  end;
  sleep(500);
end;

procedure OpenFormNew(I: integer);
var
  H, H1, H2, H3: HWND;
  hItem: HWND;
begin
  H := FindWindow('TfmAddressBookManager', nil);
  H1 := FindWindowEx(H, 0, 'TPanel', nil);
  H2 := FindWindowEx(H, H1, 'TPanel', nil);
  H3 := FindWindowEx(H2, 0, 'TTreeView', nil);
  hItem := SendMessage(H3, TVM_GETNEXTITEM, TVGN_CHILD, 0);
  if I = 0 then
    hItem := SendMessage(H3, TVM_GETNEXTITEM, TVGN_NEXT, hItem);
  SendMessage(H3, TVM_SELECTITEM, TVGN_CARET, LPARAM(hItem));
  SendMessage(H3, TVM_EXPAND, TVE_EXPAND, LPARAM(hItem));
  MenuClickButton('TfmAddressBookManager', nil, 1, 0);
end;

procedure OpenFormEditUser;
var
  H, H1, H2, H3, H4, H5, H6, H7, H8: HWND;
  G, G1, G2, G3, G4: HWND;
begin
  H := FindWindow('TfmAddEditUser', nil);
  H1 := FindWindowEx(H, 0, 'TPageControl', nil);
  H2 := FindWindowEx(H1, 0, 'TTabSheet', nil);
  H3 := FindWindowEx(H2, 0, 'TEdit', nil);
  H4 := FindWindowEx(H2, H3, 'TEdit', nil);
  H5 := FindWindowEx(H2, H4, 'TEdit', nil);
  SendMessage(H5, WM_SETTEXT, 0, Integer(PChar(Form1.Edit2.Text)));
  H6 := FindWindowEx(H2, 0, 'TButton', nil);
  LBPost(H6);
  G := FindWindow('TfmAddressBookPwd', nil);
  G1 := FindWindowEx(G, 0, 'TEdit', nil);
  SendMessage(G1, WM_SETTEXT, 0, Integer(PChar(Form1.Edit10.Text)));
  G2 := FindWindowEx(G, G1, 'TEdit', nil);
  SendMessage(G2, WM_SETTEXT, 0, Integer(PChar(Form1.Edit10.Text)));
  G3 := FindWindowEx(G, 0, 'TButton', nil);
  G4 := FindWindowEx(G, G3, 'TButton', nil);
  LBPost(G4);
  H7 := FindWindowEx(H, 0, 'TButton', nil);
  H8 := FindWindowEx(H, H7, 'TButton', nil);
  LBPost(H8);
end;

procedure CreateAddressBook;
var
  H, H1, H2, H3, H4, H5, H6: HWND;
  G, G1, G2, G3, G4: HWND;
  D, D1, D3, D4: HWND;
begin
  H := FindWindow('TfmAddEditAddressBook', nil);
  H1 := FindWindowEx(H, 0, 'TPageControl', nil);
  H2 := FindWindowEx(H1, 0, 'TTabSheet', nil);
  H3 := FindWindowEx(H2, 0, 'TEdit', nil);
  SendMessage(H3, WM_SETTEXT, 0, Integer(PChar(Form1.Edit4.Text)));
  H4 := FindWindowEx(H2, 0, 'TButton', nil);
  LBPost(H4);
  G := FindWindow('TfmAccessPage', nil);
  G1 := FindWindowEx(G, 0, 'TButton', nil);
  G2 := FindWindowEx(G, G1, 'TButton', nil);
  LBPost(G2);
  D := FindWindow('TfmSelectAccessUsersAndGroups', nil);
  D1 := FindWindowEx(D, 0, 'TListView', nil);
  SendMessage(D1, WM_SETFOCUS, 0, 0);
  SendMessage(D1, WM_KEYDOWN, VK_HOME, 0);
  SendMessage(D1, WM_KEYUP, VK_HOME, 0);
  D3 := FindWindowEx(D, 0, 'TButton', nil);
  D4 := FindWindowEx(D, D3, 'TButton', nil);
  LBPost(D4);
  G3 := FindWindowEx(G, G2, 'TButton', nil);
  G4 := FindWindowEx(G, G3, 'TButton', nil);
  LBPost(G4);
  H5 := FindWindowEx(H, 0, 'TButton', nil);
  H6 := FindWindowEx(H, H5, 'TButton', nil);
  LBPost(H6);
  MenuClickButton('TfmAddressBookManager', nil, 0, 0);
end;

procedure SettingsAutoImport;
var
  H, H1, H2, H3, H4: HWND;
  D, D1, D2, D3, D6, D7, D8, D9,
  D10, D11, D12: HWND;
  T1,T2,T3,T4,T5,T6: HWND;
  i: integer;
begin
    MenuClickButton('TfmAddressBookManager', nil, 0, 1);
    sleep(500);
    H := FindWindow('TfmAutoImport', nil);
    H1 := FindWindowEx(H, 0, 'TCheckBox', nil);
    ClickTCheckBoxСheck(H1);
    sleep(500);

    H2 := FindWindowEx(H, 0, 'TComboBox', nil);
    SendMessage(H2, CB_SETCURSEL, 0, 0);
    sleep(500);
    H3 := FindWindowEx(H, 0, 'TButton', nil);
    LBPost(H3);

    D := FindWindow('TfmAddEditConnection', nil);
    D1 := FindWindowEx(D, 0, 'TPageControl', nil);
    for i := 0 to 3 do
    begin
      VKPost(D1, VK_TAB);
    end;
    for i := 0 to 2 do
    begin
      VKPost(D1, VK_RIGHT);
    end;
    sleep(100);
    D3 := 0; D6 := 0;
    if Form1.sRadioButton1.Checked = True then
    begin
      D2 := FindWindowEx(D1, 0, 'TTabSheet', 'Безопасность');
      D3 := FindWindowEx(D1, 0, 'TTabSheet', 'Соединение');
      D6 := FindWindowEx(D2, 0, 'TGroupBox', 'Пароль');
    end
    else if Form1.sRadioButton2.Checked = True then
    begin
      D2 := FindWindowEx(D1, 0, 'TTabSheet', 'Security');
      D3 := FindWindowEx(D1, 0, 'TTabSheet', 'Connection');
      D6 := FindWindowEx(D2, 0, 'TGroupBox', 'Single password security');
    end;
    D7 := FindWindowEx(D6, 0, 'TJvEdit', nil);
    SendMessage(D7, WM_SETTEXT, 0, Integer(PChar(Form1.Edit3.Text)));
    D8 := FindWindowEx(D6, 0, 'TCheckBox', nil);
    ClickTCheckBoxСheck(D8);
    D9 := FindWindowEx(D6, D8, 'TCheckBox', nil);
    ClickTCheckBoxСheck(D9);

    for i := 0 to 1 do
    begin
      VKPost(D1, VK_LEFT);
    end;

    D10 := FindWindowEx(D3, 0, 'TRadioButton', nil);
    ClickTCheckBoxСheck(D10);

    D11 := 0;
    if Form1.sRadioButton1.Checked = True then
    begin
      D11 := FindWindowEx(D3, 0, 'TButton', 'Сменить');
    end
    else if Form1.sRadioButton2.Checked = True then
    begin
      D11 := FindWindowEx(D3, 0, 'TButton', 'Change');
    end;
    LBPost(D11);

    T1 := FindWindow('TfmSelectInetServer', nil);
    T2 := 0;
    if Form1.sRadioButton1.Checked = True then
    begin
      T2 := FindWindowEx(T1, 0, 'TCheckBox', 'Использовать стандартный');
    end
    else if Form1.sRadioButton2.Checked = True then
    begin
      T2 := FindWindowEx(T1, 0, 'TCheckBox', 'Use default server');
    end;
    ClickTCheckBoxUncheck(T2);

    T3 := FindWindowEx(T1, 0, 'TEdit', nil);
    T4 := FindWindowEx(T1, T3, 'TEdit', nil);
    SendMessage(T4, WM_SETTEXT, 0, Integer(PChar(Form1.Edit1.Text)));
    T5 :=    FindWindowEx(T1, 0, 'TRelativePanel', nil);
    T6 :=    FindWindowEx(T5, 0, 'TButton', nil);
    LBPost(T6);

    D12 := FindWindowEx(D, 0, 'TButton', 'OK');
    LBPost(D12);

    H := FindWindow('TfmAutoImport', nil);
    H4 := FindWindowEx(H, 0, 'TButton', 'OK');
    LBPost(H4);

    MenuClickButton('TfmAddressBookManager', nil, 0, 0);
    sleep(500);
    MenuClickButton('TfmAddressBookManager', nil, 0, 3);
end;

procedure SettingClientRMS;
var
  i: integer;
  H, J: HWND;
  D, D1, D2, D3, D4, D5, D6, D7, D8, D9,
  D10, D11, D12, D13, D14, D15, D16,
  D17, D18: HWND;
  Y1,Y2,Y3,Y4,Y5: HWND;
  U1, U2, U3, U4, U5, U6, U7, U8: HWND;
  myRect: TRect;
  CHB1, CHB2,CHB3,CHB4:HWND;
  T1, T2: HWND;
  CS : integer;
begin
  D := FindWindow('TfmMain', 'Viewer- Клиент');
  if D = 0 then D := FindWindow('TfmMain', 'Viewer');
  if D <> 0 then
  begin
    SendMessage(D,WM_SYSCOMMAND,SC_RESTORE,0); //развернуть окно
    SetForegroundWindow(D); //Выводим окно рмс сервера на передний план
    GetWindowRect(D, &myRect); //получаем расположение handle
    sleep(500);

    if Form1.sRadioButton2.Checked = True then
    begin
      SimulateClickWithSendInput(myRect.Left+355, myRect.top+45);
      sleep(500);
      SimulateClickWithSendInput(myRect.Left+414,myRect.top+75);
      sleep(500);
    end
    else if Form1.sRadioButton1.Checked = True then
    begin
      SimulateClickWithSendInput(myRect.Left+420,myRect.top+48);
      sleep(500);
      SimulateClickWithSendInput(myRect.Left+485,myRect.top+73);
      sleep(500);
    end;

    D1 :=  FindWindow('TfmServerList', nil);
    D2 := 0;
    if Form1.sRadioButton1.Checked = True then
    begin
      D2 := FindWindowEx(D1, 0, 'TButton', 'Добавить...');
    end
    else if Form1.sRadioButton2.Checked = True then
    begin
      D2 := FindWindowEx(D1, 0, 'TButton', 'Add...');
    end;
    LBPost(D2);

    D3 :=  FindWindow('TfmServerConnect', nil);
    D4 :=  FindWindowEx(D3, 0, 'TEdit', nil);
    SendMessage(D4, WM_SETTEXT, 0, Integer(PChar(Form1.Edit1.Text)));
    D5 :=  FindWindowEx(D3, 0, 'TRelativePanel', nil);
    D6 :=  FindWindowEx(D5, 0, 'TButton', 'OK');
    LBPost(D6);
    D7 :=  FindWindowEx(D1, 0, 'TRelativePanel', nil);
    D8 :=  FindWindowEx(D7, 0, 'TButton', 'OK');
    LBPost(D8);

    SimulateClickWithSendInput(myRect.Left+320,myRect.top+45);
    sleep(500);

    SimulateClickWithSendInput(myRect.Left+130,myRect.top+95);
    sleep(500);

    D9 :=  FindWindow('TfmConnectionOptions', nil);
    D10 :=  FindWindowEx(D9, 0, 'TPageControl', nil);
    D11 :=  FindWindowEx(D10, 0, 'TTabSheet', nil);
    if Form1.sRadioButton2.Checked = True then
      D12 :=  FindWindowEx(D11, 0, 'TGroupBox', 'Password')
    else D12 :=  FindWindowEx(D11, 0, 'TGroupBox', 'Пароль');
    D13 :=  FindWindowEx(D12, 0, 'TJvEdit', nil);
    SendMessage(D13, WM_SETTEXT, 0, Integer(PChar(Form1.Edit3.Text)));
    sleep(500);
    //чекаем чекбоксы запомнить пароль и автологон (тут пароль авторизации юзеров)
    CHB1 := FindWindowEx(D12, 0, 'TCheckBox', nil);
    ClickTCheckBoxСheck(CHB1);
    sleep(500);

    CHB2 := FindWindowEx(D12, CHB1, 'TCheckBox', nil);
    ClickTCheckBoxСheck(CHB2);
    sleep(500);

    SimulateClickWithSendInput(myRect.Left+296,myRect.top+230);
    sleep(500);


    D14 :=  FindWindowEx(D10, 0, 'TTabSheet', nil);
    D15 :=  FindWindowEx(D14, 0, 'TButton', nil);
    LBPost(D15); //клик на кнопку сменить сервер

    Y1 :=  FindWindow('TfmSelectInetServer', nil);
    Y2 :=  FindWindowEx(Y1, 0, 'TCheckBox', nil);
    Y5 :=  FindWindowEx(Y1, Y2, 'TCheckBox', nil);
    ClickTCheckBoxUncheck(Y5);
    Y3 :=  FindWindowEx(Y1, 0, 'TEdit', nil);
    SendMessage(Y3, WM_SETTEXT, 0, Integer(PChar(Form1.Edit1.Text)));
    Y4 := FindWindowEx(Y1, 0, 'TButton', nil);
    LBPost(Y4);

    D16 :=  FindWindowEx(D9, 0, 'TPanel', nil);
    D17 :=  FindWindowEx(D16, 0, 'TButton', nil);
    D18 :=  FindWindowEx(D16, D17, 'TButton', nil);
    LBPost(D18);

    SimulateClickWithSendInput(myRect.Left+1000,myRect.top+45);//НА КНОПКУ ВХОД
    sleep(500);

    U1 :=  FindWindow('TfmABLogon', nil);
    if Form1.sRadioButton2.Checked = True then
      U2 :=  FindWindowEx(U1, 0, 'TGroupBox', 'Authorization')
    else U2 :=  FindWindowEx(U1, 0, 'TGroupBox', 'Авторизация');
    U3 :=  FindWindowEx(U2, 0, 'TEdit', nil);
    SendMessage(U3, WM_SETTEXT, 0, Integer(PChar(Form1.Edit10.Text)));
    U4 :=  FindWindowEx(U2, U3, 'TEdit', nil);
    SendMessage(U4, WM_SETTEXT, 0, Integer(PChar(Form1.Edit2.Text)));
    sleep(500);

    CHB3 := FindWindowEx(U2, 0, 'TCheckBox', nil);
    CHB4 := FindWindowEx(U2, CHB3, 'TCheckBox', nil);
    ClickTCheckBoxСheck(CHB4);
    sleep(500);
    ClickTCheckBoxСheck(CHB3);
    sleep(500);

    U7 :=  FindWindowEx(U1, 0, 'TButton', nil);
    U8 :=  FindWindowEx(U1, U7, 'TButton', nil);
    LBPost(U8);
  end;
end;

procedure TForm1.sSpeedButton3Click(Sender: TObject);
begin
  LoadKeyboardLayout('00000409', KLF_ACTIVATE); //английская раскладка
  try
    // Блокирует все устройства ввода (и клавиатуру, и мышь)
    BlockInput(True);
  except
    ;
  end;
  //настройка сервера
  if sCheckBox1.Checked = True then
  begin
    MinimizeClientRMS; //сворачиваем клиент
    //открываем окно менеджер адресных книг
    if Form1.sRadioButton2.Checked = True then
      MenuClickButton('TfmMain',
          'Remote Utilities Server [local server]', 0, 1)
    else MenuClickButton('TfmMain',
          'Mini Internet-ID сервер [локальный сервер]', 0, 1);
    OpenFormNew(0); //открываем окно создать нового пользователя
    OpenFormEditUser; //создаём пользователя и пароль
    MenuClickButton('TfmAddressBookManager', nil, 0, 0); //применяем настройки
    OpenFormNew(1); //открываем окно создать адресную книгу
    CreateAddressBook; //создаём адресную книгу с правами доступа
    SettingsAutoImport; //настраиваем авто-импорт
  end;
  //настройка клиента
  if sCheckBox2.Checked = True then
  begin
    MinimizeServerRMS; //сворачиваем сервер
    SettingClientRMS; //настраиваем клиент
  end;
  try
    // Разблокировать устройства ввода
    BlockInput(False);
  except
    ;
  end;
  if Form1.sRadioButton1.Checked = True then
    ShowMessage('[Успех] Завершил настройку.')
  else ShowMessage('[Success] Setup is completed.');
end;

procedure TForm1.sCheckBox1Click(Sender: TObject);
begin
  if sCheckBox1.Checked = True then
    sCheckBox2.Checked := False;
end;

procedure TForm1.sCheckBox2Click(Sender: TObject);
begin
  if sCheckBox2.Checked = True then
    sCheckBox1.Checked := False;
end;

procedure TForm1.sSpeedButton1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Edit3.PasswordChar := #0;
end;

procedure TForm1.sSpeedButton1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Edit3.PasswordChar := Char('*');
end;

procedure TForm1.sSpeedButton2Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  FindWindowRMS;
end;

procedure TForm1.sSpeedButton3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  FindWindowRMS;
end;

procedure TForm1.sSpeedButton4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Edit10.PasswordChar := #0;
end;

procedure TForm1.sSpeedButton4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Edit10.PasswordChar := Char('*');
end;

end.
