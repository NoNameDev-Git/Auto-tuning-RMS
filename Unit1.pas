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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function MenuClickButton(SClass: PWideChar; I, J: integer): Boolean;
var
  H, H2, H3, H4: HWND;
begin
  try
    H := FindWindow(SClass, nil);
    H2 := GetMenu(H);
    H3:=GetSubMenu(H2, I);
    H4:=GetMenuItemID(H3, J);
    Result := PostMessage(H,WM_COMMAND,H4,0);
  except
    Result := False;
  end;
  sleep(1000);
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
  MenuClickButton('TfmAddressBookManager', 1, 0);
end;

procedure OpenFormEditUser();
var
  H, H1, H2, H3, H4, H5, H6, H7, H8: HWND;
  G, G1, G2, G3, G4: HWND;
begin
  sleep(500);
  H := FindWindow('TfmAddEditUser', nil);
  H1 := FindWindowEx(H, 0, 'TPageControl', nil);
  H2 := FindWindowEx(H1, 0, 'TTabSheet', nil);
  H3 := FindWindowEx(H2, 0, 'TEdit', nil);
  H4 := FindWindowEx(H2, H3, 'TEdit', nil);
  H5 := FindWindowEx(H2, H4, 'TEdit', nil);
  SendMessage(H5, WM_SETTEXT, 0, Integer(PChar(Form1.Edit2.Text)));
  H6 := FindWindowEx(H2, 0, 'TButton', nil);
  PostMessage(H6, WM_LButtonDown, 0, 0);
  PostMessage(H6, WM_LButtonUP, 0, 0);
  sleep(500);
  G := FindWindow('TfmAddressBookPwd', nil);
  G1 := FindWindowEx(G, 0, 'TEdit', nil);
  SendMessage(G1, WM_SETTEXT, 0, Integer(PChar(Form1.Edit3.Text)));
  G2 := FindWindowEx(G, G1, 'TEdit', nil);
  SendMessage(G2, WM_SETTEXT, 0, Integer(PChar(Form1.Edit3.Text)));
  G3 := FindWindowEx(G, 0, 'TButton', nil);
  G4 := FindWindowEx(G, G3, 'TButton', nil);
  PostMessage(G4, WM_LButtonDown, 0, 0);
  PostMessage(G4, WM_LButtonUP, 0, 0);
  sleep(500);
  H7 := FindWindowEx(H, 0, 'TButton', nil);
  H8 := FindWindowEx(H, H7, 'TButton', nil);
  PostMessage(H8, WM_LButtonDown, 0, 0);
  PostMessage(H8, WM_LButtonUP, 0, 0);
  sleep(500);
end;

procedure CreateAddressBook();
var
  H, H1, H2, H3, H4, H5, H6: HWND;
  G, G1, G2, G3, G4: HWND;
  D, D1, D3, D4: HWND;
begin
  sleep(500);
  H := FindWindow('TfmAddEditAddressBook', nil);
  H1 := FindWindowEx(H, 0, 'TPageControl', nil);
  H2 := FindWindowEx(H1, 0, 'TTabSheet', nil);
  H3 := FindWindowEx(H2, 0, 'TEdit', nil);
  SendMessage(H3, WM_SETTEXT, 0, Integer(PChar(Form1.Edit4.Text)));
  H4 := FindWindowEx(H2, 0, 'TButton', nil);
  PostMessage(H4, WM_LButtonDown, 0, 0);
  PostMessage(H4, WM_LButtonUP, 0, 0);
  sleep(500);
  G := FindWindow('TfmAccessPage', nil);
  G1 := FindWindowEx(G, 0, 'TButton', nil);
  G2 := FindWindowEx(G, G1, 'TButton', nil);
  PostMessage(G2, WM_LButtonDown, 0, 0);
  PostMessage(G2, WM_LButtonUP, 0, 0);
  sleep(500);
  D := FindWindow('TfmSelectAccessUsersAndGroups', nil);
  D1 := FindWindowEx(D, 0, 'TListView', nil);
  SendMessage(D1, WM_SETFOCUS, 0, 0);
  SendMessage(D1, WM_KEYDOWN, VK_HOME, 0);
  SendMessage(D1, WM_KEYUP, VK_HOME, 0);
  D3 := FindWindowEx(D, 0, 'TButton', nil);
  D4 := FindWindowEx(D, D3, 'TButton', nil);
  PostMessage(D4, WM_LButtonDown, 0, 0);
  PostMessage(D4, WM_LButtonUP, 0, 0);
  sleep(500);
  G3 := FindWindowEx(G, G2, 'TButton', nil);
  G4 := FindWindowEx(G, G3, 'TButton', nil);
  PostMessage(G4, WM_LButtonDown, 0, 0);
  PostMessage(G4, WM_LButtonUP, 0, 0);
  sleep(500);
  H5 := FindWindowEx(H, 0, 'TButton', nil);
  H6 := FindWindowEx(H, H5, 'TButton', nil);
  PostMessage(H6, WM_LButtonDown, 0, 0);
  PostMessage(H6, WM_LButtonUP, 0, 0);
  sleep(500);
  MenuClickButton('TfmAddressBookManager', 0, 0);
end;

procedure Settingsautoimport();
var
H, H1, H2, H3, H4: HWND;
D, D1, D2, D3, D6, D7, D8, D9,
D10, D11, D12: HWND;
T1,T2,T3,T4,T5,T6: HWND;
CS: Integer;
i: integer;
begin
    MenuClickButton('TfmAddressBookManager', 0, 1);
    sleep(500);
    H := FindWindow('TfmAutoImport', nil);
    H1 := FindWindowEx(H, 0, 'TCheckBox', nil);
    CS := SendMessage(H1, BM_GETCHECK, 0, 0);
    if CS = 0 then
    begin
      SendMessage(H1, BM_SETSTATE, 1, 0);
      SendMessage(H1, BM_CLICK, 0, 0);
    end;
    H2 := FindWindowEx(H, 0, 'TComboBox', nil);
    SendMessage(H2, CB_SETCURSEL, 0, 0);
    sleep(500);
    H3 := FindWindowEx(H, 0, 'TButton', nil);
    PostMessage(H3, WM_LButtonDown, 0, 0);
    PostMessage(H3, WM_LButtonUP, 0, 0);
    sleep(500);


    D := FindWindow('TfmAddEditConnection', nil);
    D1 := FindWindowEx(D, 0, 'TPageControl', nil);
    for i := 0 to 3 do
    begin
      PostMessage(D1, WM_KEYDOWN, VK_TAB, 0);
      PostMessage(D1, WM_KEYUP, VK_TAB, 0);
      sleep(100);
    end;
    for i := 0 to 2 do
    begin
      PostMessage(D1, WM_KEYDOWN, VK_RIGHT, 0);
      PostMessage(D1, WM_KEYUP, VK_RIGHT, 0);
      sleep(100);
    end;
    sleep(100);
    if Form1.sRadioButton1.Checked = True then
    begin
      D2 := FindWindowEx(D1, 0, 'TTabSheet', 'Безопасность');
      D3 := FindWindowEx(D1, 0, 'TTabSheet', 'Соединение');
      D6 := FindWindowEx(D2, 0, 'TGroupBox', 'Пароль');
      D7 := FindWindowEx(D6, 0, 'TJvEdit', nil);
      SendMessage(D7, WM_SETTEXT, 0, Integer(PChar(Form1.Edit3.Text)));
      D8 := FindWindowEx(D6, 0, 'TCheckBox', nil);
      CS := SendMessage(D8, BM_GETCHECK, 0, 0);
      if CS = 0 then
      begin
        SendMessage(D8, BM_SETSTATE, 1, 0);
        SendMessage(D8, BM_CLICK, 0, 0);
      end;
      D9 := FindWindowEx(D6, D8, 'TCheckBox', nil);
      CS := SendMessage(D9, BM_GETCHECK, 0, 0);
      if CS = 0 then
      begin
        SendMessage(D9, BM_SETSTATE, 1, 0);
        SendMessage(D9, BM_CLICK, 0, 0);
      end;

      for i := 0 to 1 do
      begin
        PostMessage(D1, WM_KEYDOWN, VK_LEFT, 0);
        PostMessage(D1, WM_KEYUP, VK_LEFT, 0);
        sleep(100);
      end;

      D10 := FindWindowEx(D3, 0, 'TRadioButton', nil);
      CS := SendMessage(D10, BM_GETCHECK, 0, 0);
      if CS = 0 then
      begin
        SendMessage(D10, BM_SETSTATE, 1, 0);
        SendMessage(D10, BM_CLICK, 0, 0);
      end;

      if Form1.sRadioButton1.Checked = True then
      begin
        D11 := FindWindowEx(D3, 0, 'TButton', 'Сменить');
        PostMessage(D11, WM_LButtonDown, 0, 0);
        PostMessage(D11, WM_LButtonUP, 0, 0);
        sleep(500);
      end
      else if Form1.sRadioButton2.Checked = True then
      begin
        D11 := FindWindowEx(D3, 0, 'TButton', 'Change');
        PostMessage(D11, WM_LButtonDown, 0, 0);
        PostMessage(D11, WM_LButtonUP, 0, 0);
        sleep(500);
      end;

    end
    else if Form1.sRadioButton2.Checked = True then
    begin
      D2 := FindWindowEx(D1, 0, 'TTabSheet', 'Security');
      D3 := FindWindowEx(D1, 0, 'TTabSheet', 'Connection');
      D6 := FindWindowEx(D2, 0, 'TGroupBox', 'Single password security');
      D7 := FindWindowEx(D6, 0, 'TJvEdit', nil);
      SendMessage(D7, WM_SETTEXT, 0, Integer(PChar(Form1.Edit3.Text)));
      D8 := FindWindowEx(D6, 0, 'TCheckBox', nil);
      CS := SendMessage(D8, BM_GETCHECK, 0, 0);
      if CS = 0 then
      begin
        SendMessage(D8, BM_SETSTATE, 1, 0);
        SendMessage(D8, BM_CLICK, 0, 0);
      end;
      D9 := FindWindowEx(D6, D8, 'TCheckBox', nil);
      CS := SendMessage(D9, BM_GETCHECK, 0, 0);
      if CS = 0 then
      begin
        SendMessage(D9, BM_SETSTATE, 1, 0);
        SendMessage(D9, BM_CLICK, 0, 0);
      end;

      for i := 0 to 1 do
      begin
        PostMessage(D1, WM_KEYDOWN, VK_LEFT, 0);
        PostMessage(D1, WM_KEYUP, VK_LEFT, 0);
        sleep(100);
      end;

      D10 := FindWindowEx(D3, 0, 'TRadioButton', nil);
      CS := SendMessage(D10, BM_GETCHECK, 0, 0);
      if CS = 0 then
      begin
        SendMessage(D10, BM_SETSTATE, 1, 0);
        SendMessage(D10, BM_CLICK, 0, 0);
      end;

      if Form1.sRadioButton1.Checked = True then
      begin
        D11 := FindWindowEx(D3, 0, 'TButton', 'Сменить');
        PostMessage(D11, WM_LButtonDown, 0, 0);
        PostMessage(D11, WM_LButtonUP, 0, 0);
        sleep(500);
      end
      else if Form1.sRadioButton2.Checked = True then
      begin
        D11 := FindWindowEx(D3, 0, 'TButton', 'Change');
        PostMessage(D11, WM_LButtonDown, 0, 0);
        PostMessage(D11, WM_LButtonUP, 0, 0);
        sleep(500);
      end;
    end;

    T1 := FindWindow('TfmSelectInetServer', nil);
    if Form1.sRadioButton1.Checked = True then
    begin
      T2 := FindWindowEx(T1, 0, 'TCheckBox', 'Использовать стандартный');
      CS := SendMessage(T2, BM_GETCHECK, 0, 0);
      if CS <> 0 then
      begin
        SendMessage(T2, BM_SETSTATE, 0, 0);
        SendMessage(T2, BM_CLICK, 0, 0);
      end;
    end
    else if Form1.sRadioButton2.Checked = True then
    begin
      T2 := FindWindowEx(T1, 0, 'TCheckBox', 'Use default server');
      CS := SendMessage(T2, BM_GETCHECK, 0, 0);
      if CS <> 0 then
      begin
        SendMessage(T2, BM_SETSTATE, 0, 0);
        SendMessage(T2, BM_CLICK, 0, 0);
      end;
    end;

    T3 := FindWindowEx(T1, 0, 'TEdit', nil);
    T4 := FindWindowEx(T1, T3, 'TEdit', nil);
    SendMessage(T4, WM_SETTEXT, 0, Integer(PChar(Form1.Edit1.Text)));
    T5 :=    FindWindowEx(T1, 0, 'TRelativePanel', nil);
    T6 :=    FindWindowEx(T5, 0, 'TButton', nil);
    PostMessage(T6, WM_LButtonDown, 0, 0);
    PostMessage(T6, WM_LButtonUP, 0, 0);
    sleep(500);
    if Form1.sRadioButton1.Checked = True then
    begin
      D12 := FindWindowEx(D, 0, 'TButton', 'OK');
      PostMessage(D12, WM_LButtonDown, 0, 0);
      PostMessage(D12, WM_LButtonUP, 0, 0);
      sleep(500);
    end
    else if Form1.sRadioButton2.Checked = True then
    begin
      D12 := FindWindowEx(D, 0, 'TButton', 'OK');
      PostMessage(D12, WM_LButtonDown, 0, 0);
      PostMessage(D12, WM_LButtonUP, 0, 0);
      sleep(500);
    end;

    H := FindWindow('TfmAutoImport', nil);
    if Form1.sRadioButton1.Checked = True then
    begin
      H4 := FindWindowEx(H, 0, 'TButton', 'OK');
      PostMessage(H4, WM_LButtonDown, 0, 0);
      PostMessage(H4, WM_LButtonUP, 0, 0);
      sleep(500);
    end
    else if Form1.sRadioButton2.Checked = True then
    begin
      H4 := FindWindowEx(H, 0, 'TButton', 'OK');
      PostMessage(H4, WM_LButtonDown, 0, 0);
      PostMessage(H4, WM_LButtonUP, 0, 0);
      sleep(500);
    end;

    MenuClickButton('TfmAddressBookManager', 0, 0);
    sleep(500);
    MenuClickButton('TfmAddressBookManager', 0, 3);
end;


function GetMainWindowHandle(ProcessName: string): HWND;
var
  Snapshot: THandle;
  ProcessEntry: TProcessEntry32;
  hhWnd: HWND;
  PID: DWORD;
begin
  Result := 0;
  Snapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if Snapshot = INVALID_HANDLE_VALUE then Exit;
  try
    ProcessEntry.dwSize := SizeOf(TProcessEntry32);
    if Process32First(Snapshot, ProcessEntry) then
    begin
      repeat
        if SameText(ProcessName, string(ProcessEntry.szExeFile)) then
        begin
          PID := ProcessEntry.th32ProcessID;
          hhWnd := FindWindow(nil, nil);
          while hhWnd <> 0 do
          begin
            if GetWindowThreadProcessId(hhWnd, nil) = PID then
            begin
              Result := hhWnd;
              Exit;
            end;
            hhWnd := GetWindow(hhWnd, GW_HWNDNEXT);
          end;
        end;
      until not Process32Next(Snapshot, ProcessEntry);
    end;
  finally
    CloseHandle(Snapshot);
  end;
end;

procedure RestoreAndFocusWindow(WindowHandle: HWND);
begin
  if IsIconic(WindowHandle) then
    ShowWindow(WindowHandle, SW_RESTORE)
  else if not IsWindowVisible(WindowHandle) then
    ShowWindow(WindowHandle, SW_SHOW);
  SetForegroundWindow(WindowHandle);
end;

procedure TForm1.FormShow(Sender: TObject);
var
  H,J:HWND;
begin
  if sCheckBox1.Checked = True then
  begin
    H := FindWindow('TfmMain', 'Mini Internet-ID сервер [локальный сервер]');
    J := FindWindow('TfmMain', 'Remote Utilities Server [local server]');
    if H <> 0 then  sRadioButton1.Checked := True;
    if J <> 0 then  sRadioButton2.Checked := True;
    Application.ProcessMessages;
  end;
  if sCheckBox2.Checked = True then
  begin
    H := FindWindow('TfmMain', 'Viewer- Клиент');
    J := FindWindow('TfmMain', 'Viewer');
    if H <> 0 then  sRadioButton1.Checked := True;
    if J <> 0 then  sRadioButton2.Checked := True;
    Application.ProcessMessages;

  end;
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

procedure TForm1.sSpeedButton3Click(Sender: TObject);
var
  i: integer;
  H, J: HWND;
  D, D1, D2, D3, D4, D5, D6, D7, D8, D9,
  D10, D11, D12, D13, D14, D15, D16,
  D17: HWND;
  myRect: TRect;
  s: string;
begin
  //английская раскладка
  LoadKeyboardLayout('00000409', KLF_ACTIVATE);
  BlockInput(True);  // Блокирует все устройства ввода (и клавиатуру, и мышь)
  //настройка сервера
  if sCheckBox1.Checked = True then
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
    //открываем окно менеджер адресных книг
    MenuClickButton('TfmMain', 0, 1);
    //открываем окно создать нового пользователя
    OpenFormNew(0);
    //создаём пользователя и пароль
    OpenFormEditUser();
    //применяем настройки
    MenuClickButton('TfmAddressBookManager', 0, 0);
    //открываем окно создать адресную книгу
    OpenFormNew(1);
    //создаём адресную книгу с правами доступа
    CreateAddressBook();
    //настраиваем авто-импорт
    Settingsautoimport();
  end;

  //настройка клиента
  if sCheckBox2.Checked = True then
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
    D := FindWindow('TfmMain', 'Viewer- Клиент');
    if D = 0 then D := FindWindow('TfmMain', 'Viewer');
    if D <> 0 then
    begin
      //Выводим окно рмс сервера на передний план
      SetForegroundWindow(D);
      GetWindowRect(D, &myRect); //получаем расположение handle
      sleep(500);

      if sRadioButton2.Checked = True then
      begin
        SetCursorPos(myRect.Left+355,myRect.top+45); //устанавливаем курсор на handle окна
        //кликаем левой кнопкой мыши
        mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTDOWN, myRect.Left+355, myRect.top+45, 0, 0); // опускаем левую клавишу мыши по заданным координатам
        mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTUP, myRect.Left+355, myRect.top+45, 0, 0); //

        sleep(500);
        SetCursorPos(myRect.Left+460,myRect.top+70); //устанавливаем курсор на handle окна
        //кликаем левой кнопкой мыши
        mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTDOWN, myRect.Left+460, myRect.top+70, 0, 0); // опускаем левую клавишу мыши по заданным координатам
        mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTUP, myRect.Left+460, myRect.top+70, 0, 0); //
        sleep(500);
      end
      else if sRadioButton1.Checked = True then
      begin
        SetCursorPos(myRect.Left+390,myRect.top+45); //устанавливаем курсор на handle окна
        //кликаем левой кнопкой мыши
        mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTDOWN, myRect.Left+390, myRect.top+45, 0, 0); // опускаем левую клавишу мыши по заданным координатам
        mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTUP, myRect.Left+390, myRect.top+45, 0, 0); //

        sleep(500);
        SetCursorPos(myRect.Left+470,myRect.top+70); //устанавливаем курсор на handle окна
        //кликаем левой кнопкой мыши
        mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTDOWN, myRect.Left+470, myRect.top+70, 0, 0); // опускаем левую клавишу мыши по заданным координатам
        mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTUP, myRect.Left+470, myRect.top+70, 0, 0); //
        sleep(500);
      end;


      D1 :=  FindWindow('TfmServerList', nil);
      if sRadioButton1.Checked = True then
      begin
        D2 := FindWindowEx(D1, 0, 'TButton', 'Добавить...');
        PostMessage(D2, WM_LButtonDown, 0, 0);
        PostMessage(D2, WM_LButtonUP, 0, 0);
        sleep(500);
      end
      else if sRadioButton2.Checked = True then
      begin
        D2 := FindWindowEx(D1, 0, 'TButton', 'Add...');
        PostMessage(D2, WM_LButtonDown, 0, 0);
        PostMessage(D2, WM_LButtonUP, 0, 0);
        sleep(500);
      end;

      D3 :=  FindWindow('TfmServerConnect', nil);
      D4 :=  FindWindowEx(D3, 0, 'TEdit', nil);
      SendMessage(D4, WM_SETTEXT, 0, Integer(PChar(Form1.Edit1.Text)));
      D5 :=  FindWindowEx(D3, 0, 'TRelativePanel', nil);
      D6 :=  FindWindowEx(D5, 0, 'TButton', 'OK');
      PostMessage(D6, WM_LButtonDown, 0, 0);
      PostMessage(D6, WM_LButtonUP, 0, 0);
      sleep(500);
      D7 :=  FindWindowEx(D1, 0, 'TRelativePanel', nil);
      D8 :=  FindWindowEx(D7, 0, 'TButton', 'OK');
      PostMessage(D8, WM_LButtonDown, 0, 0);
      PostMessage(D8, WM_LButtonUP, 0, 0);
      sleep(500);

      SetCursorPos(myRect.Left+320,myRect.top+45); //устанавливаем курсор на handle окна
      //кликаем левой кнопкой мыши
      mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTDOWN, myRect.Left+320, myRect.top+45, 0, 0); // опускаем левую клавишу мыши по заданным координатам
      mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTUP, myRect.Left+320, myRect.top+45, 0, 0); //

      sleep(500);
      SetCursorPos(myRect.Left+130,myRect.top+95); //устанавливаем курсор на handle окна
      //кликаем левой кнопкой мыши
      mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTDOWN, myRect.Left+130, myRect.top+95, 0, 0); // опускаем левую клавишу мыши по заданным координатам
      mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTUP, myRect.Left+130, myRect.top+95, 0, 0); //
      sleep(500);

      D9 :=  FindWindow('TfmConnectionOptions', nil);
      D10 :=  FindWindowEx(D9, 0, 'TPageControl', nil);
      if sRadioButton2.Checked = True then
      begin
        D11 :=  FindWindowEx(D10, 0, 'TTabSheet', 'Security');
        D12 :=  FindWindowEx(D11, 0, 'TGroupBox', 'Password');
        D13 :=  FindWindowEx(D12, 0, 'TJvEdit', nil);
        SendMessage(D13, WM_SETTEXT, 0, Integer(PChar(Form1.Edit3.Text)));
      end;
      if sRadioButton1.Checked = True then
      begin
        D11 :=  FindWindowEx(D10, 0, 'TTabSheet', 'Безопасность');
        D12 :=  FindWindowEx(D11, 0, 'TGroupBox', 'Пароль');
        D13 :=  FindWindowEx(D12, 0, 'TJvEdit', nil);
        SendMessage(D13, WM_SETTEXT, 0, Integer(PChar(Form1.Edit3.Text)));
      end;


      sleep(500);
      SetCursorPos(myRect.Left+466,myRect.top+256); //устанавливаем курсор на handle окна
      //кликаем левой кнопкой мыши
      mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTDOWN, myRect.Left+466, myRect.top+256, 0, 0); // опускаем левую клавишу мыши по заданным координатам
      mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTUP, myRect.Left+466, myRect.top+256, 0, 0); //

      sleep(500);
      SetCursorPos(myRect.Left+466,myRect.top+286); //устанавливаем курсор на handle окна
      //кликаем левой кнопкой мыши
      mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTDOWN, myRect.Left+466, myRect.top+286, 0, 0); // опускаем левую клавишу мыши по заданным координатам
      mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTUP, myRect.Left+466, myRect.top+286, 0, 0); //

      sleep(500);
      SetCursorPos(myRect.Left+296,myRect.top+230); //устанавливаем курсор на handle окна
      //кликаем левой кнопкой мыши
      mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTDOWN, myRect.Left+296, myRect.top+230, 0, 0); // опускаем левую клавишу мыши по заданным координатам
      mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTUP, myRect.Left+296, myRect.top+230, 0, 0); //

      sleep(500);
      SetCursorPos(myRect.Left+490,myRect.top+224); //устанавливаем курсор на handle окна
      //кликаем левой кнопкой мыши
      mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTDOWN, myRect.Left+490, myRect.top+224, 0, 0); // опускаем левую клавишу мыши по заданным координатам
      mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTUP, myRect.Left+490, myRect.top+224, 0, 0); //

      sleep(500);
      SetCursorPos(myRect.Left+362,myRect.top+304); //устанавливаем курсор на handle окна
      //кликаем левой кнопкой мыши
      mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTDOWN, myRect.Left+362, myRect.top+304, 0, 0); // опускаем левую клавишу мыши по заданным координатам
      mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTUP, myRect.Left+362, myRect.top+304, 0, 0); //

      sleep(500);
      SetCursorPos(myRect.Left+370,myRect.top+380); //устанавливаем курсор на handle окна
      //кликаем левой кнопкой мыши
      mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTDOWN, myRect.Left+370, myRect.top+380, 0, 0); // опускаем левую клавишу мыши по заданным координатам
      mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTUP, myRect.Left+370, myRect.top+380, 0, 0); //

      sleep(500);
      s := Edit1.Text;
      for i := 1 to s.Length do
      begin
        if s[i] = '.' then
        begin
          keybd_event(VK_OEM_PERIOD, 0, 0, 0);  // Нажатие клавиши точки
          keybd_event(VK_OEM_PERIOD, 0, KEYEVENTF_KEYUP, 0);  // Отпускание клавиши точки
        end
        else
        begin
          keybd_event(Ord(s[i]), 0, 0, 0);
          keybd_event(Ord(s[i]), 0, KEYEVENTF_KEYUP, 0);
        end;
        sleep(10);
      end;

      sleep(500);
      SetCursorPos(myRect.Left+620,myRect.top+480); //устанавливаем курсор на handle окна
      //кликаем левой кнопкой мыши
      mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTDOWN, myRect.Left+620, myRect.top+480, 0, 0); // опускаем левую клавишу мыши по заданным координатам
      mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTUP, myRect.Left+620, myRect.top+480, 0, 0); //

      sleep(500);
      SetCursorPos(myRect.Left+630,myRect.top+600); //устанавливаем курсор на handle окна
      //кликаем левой кнопкой мыши
      mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTDOWN, myRect.Left+630, myRect.top+600, 0, 0); // опускаем левую клавишу мыши по заданным координатам
      mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTUP, myRect.Left+630, myRect.top+600, 0, 0); //

      //////НА КНОПКУ ВХОД
      sleep(500);
      SetCursorPos(myRect.Left+1000,myRect.top+45); //устанавливаем курсор на handle окна
      //кликаем левой кнопкой мыши
      mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTDOWN, myRect.Left+1000, myRect.top+45, 0, 0); // опускаем левую клавишу мыши по заданным координатам
      mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTUP, myRect.Left+1000, myRect.top+45, 0, 0); //
      sleep(500);

      D14 :=  FindWindow('TfmABLogon', nil);
      if sRadioButton2.Checked = True then
      begin
        D15 :=  FindWindowEx(D14, 0, 'TGroupBox', 'Authorization');
        D16 :=  FindWindowEx(D15, 0, 'TEdit', nil);
        SendMessage(D16, WM_SETTEXT, 0, Integer(PChar(Form1.Edit3.Text)));
        D17 :=  FindWindowEx(D15, D16, 'TEdit', nil);
        SendMessage(D17, WM_SETTEXT, 0, Integer(PChar(Form1.Edit2.Text)));
      end;
      if sRadioButton1.Checked = True then
      begin
        D15 :=  FindWindowEx(D14, 0, 'TGroupBox', 'Авторизация');
        D16 :=  FindWindowEx(D15, 0, 'TEdit', nil);
        SendMessage(D16, WM_SETTEXT, 0, Integer(PChar(Form1.Edit3.Text)));
        D17 :=  FindWindowEx(D15, D16, 'TEdit', nil);
        SendMessage(D17, WM_SETTEXT, 0, Integer(PChar(Form1.Edit2.Text)));
      end;


      sleep(500);
      SetCursorPos(myRect.Left+400,myRect.top+360); //устанавливаем курсор на handle окна
      //кликаем левой кнопкой мыши
      mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTDOWN, myRect.Left+400, myRect.top+360, 0, 0); // опускаем левую клавишу мыши по заданным координатам
      mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTUP, myRect.Left+400, myRect.top+360, 0, 0); //

      sleep(500);
      SetCursorPos(myRect.Left+400,myRect.top+390); //устанавливаем курсор на handle окна
      //кликаем левой кнопкой мыши
      mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTDOWN, myRect.Left+400, myRect.top+390, 0, 0); // опускаем левую клавишу мыши по заданным координатам
      mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTUP, myRect.Left+400, myRect.top+390, 0, 0); //

      sleep(500);
      SetCursorPos(myRect.Left+600,myRect.top+538); //устанавливаем курсор на handle окна
      //кликаем левой кнопкой мыши
      mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTDOWN, myRect.Left+600, myRect.top+538, 0, 0); // опускаем левую клавишу мыши по заданным координатам
      mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTUP, myRect.Left+600, myRect.top+538, 0, 0); //
    end;
  end;
  BlockInput(False); // Разблокировать устройства ввода
  if Form1.sRadioButton1.Checked = True then
      ShowMessage('[Успех] Завершил настройку.')
    else
      ShowMessage('[Success] Setup is completed.');
end;


procedure TForm1.sSpeedButton3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  H,J:HWND;
begin
  if sCheckBox1.Checked = True then
  begin
    H := FindWindow('TfmMain', 'Mini Internet-ID сервер [локальный сервер]');
    J := FindWindow('TfmMain', 'Remote Utilities Server [local server]');
    if H <> 0 then  sRadioButton1.Checked := True;
    if J <> 0 then  sRadioButton2.Checked := True;
    Application.ProcessMessages;
  end;
  if sCheckBox2.Checked = True then
  begin
    H := FindWindow('TfmMain', 'Viewer- Клиент');
    J := FindWindow('TfmMain', 'Viewer');
    if H <> 0 then  sRadioButton1.Checked := True;
    if J <> 0 then  sRadioButton2.Checked := True;
    Application.ProcessMessages;
  end;
end;

end.
