#!/usr/bin/perl
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

use utf8;

# --------------------------------

$Lang{Start_Archive}        = "Zacznij Archiwizację";
$Lang{Stop_Dequeue_Archive} = "Zatrzymaj/Odkolejkuj Archiwizację";
$Lang{Start_Full_Backup}    = "Zacznij Pełną Kopię Zapasową";
$Lang{Start_Incr_Backup}    = "Zacznij Inkrementacyjną Kopię Zapasową";
$Lang{Stop_Dequeue_Backup}  = "Zatrzymaj/Odkolejkuj Kopię Zapasową";
$Lang{Restore}              = "Przywróć";

$Lang{Type_full} = "pełny";
$Lang{Type_incr} = "inkrementacyjny";

# -----

$Lang{Only_privileged_users_can_view_admin_options} =
  "Tylko uprzywilejowani użytkownicy mogą oglądać opcje administracyjne";
$Lang{H_Admin_Options}    = "Serwer BackupPC: Opcje Administracyjne";
$Lang{Admin_Options}      = "Opcje Administracyjne";
$Lang{Admin_Options_Page} = <<EOF;
\${h1(qq{$Lang{Admin_Options}})}
<br>
\${h2("Kontrola Serwera")}
<form name="ReloadForm" action="\$MyURL" method="get">
  <input type="hidden" name="action" value="">
  <table class="tableStnd tbl-Admin_Options_Page-reload">
    <tr>
      <td>Wczytaj ponownie konfigurację serwera:<td class="hasButtons">
      <input type="button" value="Wczytaj ponownie" onClick="document.ReloadForm.action.value='Reload'; document.ReloadForm.submit();">
    </tr>
  </table>
</form>
<!--
\${h2("Konfiguracja Serwera")}
<ul>
  <li><i>Inne opcje mogą być tu ... . tzn,</i></li>
  <li>Edytuj Konfigurację Serwera</li>
</ul>
-->
EOF

$Lang{Unable_to_connect_to_BackupPC_server}               = "Nie można połączyć się z serwerem BackupPC";
$Lang{Unable_to_connect_to_BackupPC_server_error_message} = <<EOF;
Ten skrypt CGI (\$MyURL) nie może połączyć się z serwerem BackupPC na\$Conf{ServerHost} porcie \$Conf{ServerPort}.
<br>
Błąd to: \$err.
<br>
+Możliwe, że serwer BackupPC jest wyłączony albo że występuje błąd w konfiguracji. Proszę zgłoś to swojemu administratorowi.
EOF

$Lang{Admin_Start_Server} = <<EOF;
\${h1(qq{$Lang{Unable_to_connect_to_BackupPC_server}})}
<form action="\$MyURL" method="get">
  Serwer BackupPC na <tt>\$Conf{ServerHost}</tt> porcie <tt>\$Conf{ServerPort}</tt> nie działa (może go wyłączyłeś, albo zapomniałeś włączyć).
  <br>
  Czy chcesz go włączyć?
  <input type="hidden" name="action" value="startServer">
  <input type="submit" value="Uruchom serwer BackupPC" name="ignore">
</form>
EOF

# -----

$Lang{H_BackupPC_Server_Status} = "Status Serwera BackupPC";

$Lang{BackupPC_Server_Status_General_Info} = <<EOF;
\${h2(\"Informacje Ogólne Serwera\")}

<ul>
  <li>PID to \$Info{pid}, na hoście \$Conf{ServerHost}, wersja \$Info{Version}, włączony od \$serverStartTime.</li>
  <li>Moment wygenerowania statusu: \$now.</li>
  <li>Ostatnie ładowanie konfiguracji: \$configLoadTime.</li>
  <li>Następne budzenie: \$nextWakeupTime.
  <li>Pozostałe informacje:
    <ul>
      <li>\$numBgQueue oczekujących żądań kopii zapasowych od ostatniego zaplanowanego budzenia,
      <li>\$numUserQueue oczekujacych żądań kopii zapasowych od użytkowników,
      <li>\$numCmdQueue oczekujących poleceń do wykonania,
      \$poolInfo
      <li>Procent zajęcia systemu plików to \$Info{DUlastValue}% (\$DUlastTime). Dzisiejsza maksymalna wartość to \$Info{DUDailyMax}% (\$DUmaxTime), a wczorajsza to \$Info{DUDailyMaxPrev}%.
      <li>(Inode) Procent zajęcia systemu plików to \$Info{DUInodelastValue}% (\$DUlastTime). Dzisiejsza maksymalna wartość to \$Info{DUInodeDailyMax}% (\$DUInodemaxTime), a wczorajsza to \$Info{DUInodeDailyMaxPrev}%.
    </ul>
</ul>
EOF

$Lang{BackupPC_Server_Status} = <<EOF;
\${h1(qq{$Lang{H_BackupPC_Server_Status}})}

<p>
\${h2("Aktualnie Działające Zadania")}
<p>
<table class="tableStnd sortable tbl-BackupPC_Server_Status-jobs" border cellspacing="1" cellpadding="3">
  <tr class="tableheader">
    <td>Host</td>
    <td>Typ</td>
    <td>Użytkownik</td>
    <td>Początek</td>
    <td>Polecenie</td>
    <td align="center">PID</td>
    <td align="center">Xfer PID</td>
    <td align="center">Status</td>
    <td align="center">Count</td>  <!-- TODO: translate -->
  </tr>
\$jobStr
</table>
<p>
\$generalInfo
\${h2("Błędy które wymagają uwagi człowieka")}
<p>
<table class="tableStnd sortable tbl-BackupPC_Server_Status-failures" border cellspacing="1" cellpadding="3">
  <tr class="tableheader">
    <td align="center">Host</td>
    <td align="center">Typ</td>
    <td align="center">Użytkownik</td>
    <td align="center">Ostatnia próba</td>
    <td align="center">Szczegóły</td>
    <td align="center">Czas</td>
    <td>Ostatni błąd (inny niż brak połączenia(pingu))</td>
  </tr>
  \$statusStr
</table>
EOF

# --------------------------------
$Lang{BackupPC__Server_Summary} = "BackupPC: Wyciąg Hostów";
$Lang{BackupPC__Archive}        = "BackupPC: Archiwum";
$Lang{BackupPC_Summary}         = <<EOF;

\${h1(qq{$Lang{BackupPC__Server_Summary}})}
<p>
<ul>
  <li>Moment wygenerowania statusu: \$now.
  <li>Procent zajęcia systemu plików to \$Info{DUlastValue}% (\$DUlastTime). Dzisiejsza maksymalna wartość to \$Info{DUDailyMax}% (\$DUmaxTime), a wczorajsza to \$Info{DUDailyMaxPrev}%.

  <li>(Inode) Procent zajęcia systemu plików to \$Info{DUInodelastValue}% (\$DUlastTime). Dzisiejsza maksymalna wartość to \$Info{DUInodeDailyMax}% (\$DUInodemaxTime), a wczorajsza to \$Info{DUInodeDailyMaxPrev}%.
</ul>
</p>
\${h2("Hosty z poprawnie wykonaną kopią zapasową")}
<p>
Jest \$hostCntGood hostów które zostały zabezpieczone:
<ul>
  <li>\$fullTot pełnych kopii zapasowych na pełną sumę \${fullSizeTot}GB (przed kompresją),</li>
  <li>\$incrTot inkrementalnych kopii zapasowych na pełną sumę \${incrSizeTot}GB (przed kompresją).</li>
</ul>
</p>
<table class="sortable tbl-BackupPC_Summary-Hosts_with_good_Backups" id="host_summary_backups" border cellpadding="3" cellspacing="1">
  <tr class="tableheader">
    <td>Host</td>
    <td align="center">Użytkownik</td>
    <td align="center">Komentarz</td>
    <td align="center">Liczba k. pełnych</td>
    <td align="center">Wiek k. pełnej (dni)</td>
    <td align="center">Rozmiar (GB)</td>
    <td align="center">Prędkość (MB/s)</td>
    <td align="center">Liczba k. inkr.</td>
    <td align="center">Wiek k. inkr. (dni)</td>
    <td align="center">Wiek (dni)</td>
    <td align="center">Status</td>
    <td align="center">Błędy Xfer</td>
    <td align="center">Ostatnia próba</td>
  </tr>
  \$strGood
</table>
\${h2("Hosty bez wykonanej żadnej kopii zapasowej")}
<p>
Jest \$hostCntNone hostów bez żadnej kopii zapasowej.
<p>
<table class="sortable tbl-BackupPC_Summary-Hosts_with_no_Backups" id="host_summary_nobackups" border cellpadding="3" cellspacing="1">
  <tr class="tableheader">
    <td>Host</td>
    <td align="center">Użytkownik</td>
    <td align="center">Komentarz</td>
    <td align="center">Liczba k. pełnych</td>
    <td align="center">Wiek k. pełnej (dni)</td>
    <td align="center">Rozmiar (GiB)</td>
    <td align="center">Prędkość (MB/s)</td>
    <td align="center">Liczba k. inkr.</td>
    <td align="center">Wiek k. inkr. (dni)</td>
    <td align="center">Wiek (dni)</td>
    <td align="center">Status </td>
    <td align="center">Błędy Xfer</td>
    <td align="center">Ostatnia próba</td>
  </tr>
  \$strNone
</table>
EOF

$Lang{BackupPC_Archive} = <<EOF;
\${h1(qq{$Lang{BackupPC__Archive}})}
<script language="javascript" type="text/javascript">
<!--

    function checkAll(location)
    {
      for (var i=0;i<document.form1.elements.length;i++)
      {
        var e = document.form1.elements[i];
        if ((e.checked || !e.checked) && e.name != \'all\') {
            if (eval("document.form1."+location+".checked")) {
                e.checked = true;
            } else {
                e.checked = false;
            }
        }
      }
    }

    function toggleThis(checkbox)
    {
       var cb = eval("document.form1."+checkbox);
       cb.checked = !cb.checked;
    }

//-->
</script>
Jest \$hostCntGood hostów, które mają kopie zapasowe na sumę \${fullSizeTot}GiB
<p>
<form name="form1" method="post" action="\$MyURL">
  <input type="hidden" name="fcbMax" value="\$checkBoxCnt">
  <input type="hidden" name="type" value="1">
  <input type="hidden" name="host" value="\${EscHTML(\$archHost)}">
  <input type="hidden" name="action" value="Archive">
  <table class="tableStnd tbl-BackupPC_Archive-hosts" border cellpadding="3" cellspacing="1">
    <tr class="tableheader">
      <td align=center>Host</td>
      <td align="center">Użytkownik</td>
      <td align="center">Rozmiar Kopii Zapasowej</td>
    </tr>
    \$strGood
    \$checkAllHosts
  </table>
</form>
<p>
EOF

$Lang{BackupPC_Archive2} = <<EOF;
\${h1(qq{$Lang{BackupPC__Archive}})}
Przystępuję do archiwizacji następujących hostów
<ul>
  \$HostListStr
</ul>
<form action="\$MyURL" method="post">
  \$hiddenStr
  <input type="hidden" name="action" value="Archive">
  <input type="hidden" name="host" value="\${EscHTML(\$archHost)}">
  <input type="hidden" name="type" value="2">
  <input type="hidden" value="0" name="archive_type">
  <table class="tableStnd tbl-BackupPC_Archive-start" border cellspacing="1" cellpadding="3">
    \$paramStr
    <tr>
      <td colspan=2><input type="submit" value="Start the Archive" name="ignore"></td>
    </tr>
  </table>
</form>
EOF

$Lang{BackupPC_Archive2_location} = <<EOF;
<tr>
    <td>Lokalizacja Archiwum</td>
    <td><input type="text" value="\$ArchiveDest" name="archive_device"></td>
</tr>
EOF

$Lang{BackupPC_Archive2_compression} = <<EOF;
<tr>
  <td>Kompresja</td>
  <td>
    <input type="radio" value="0" name="compression" \$ArchiveCompNone>None<br>
    <input type="radio" value="1" name="compression" \$ArchiveCompGzip>gzip<br>
    <input type="radio" value="2" name="compression" \$ArchiveCompBzip2>bzip2
  </td>
</tr>
EOF

$Lang{BackupPC_Archive2_parity} = <<EOF;
<tr>
  <td>Procent "parity data" (0 = wyłączone, 5 = typowe)</td>
  <td><input type="numeric" value="\$ArchivePar" name="par"></td>
</tr>
EOF

$Lang{BackupPC_Archive2_split} = <<EOF;
<tr>
  <td>Rozdziel wyjście na </td>
  <td><input type="numeric" value="\$ArchiveSplit" name="splitsize">Megabajtów</td>
</tr>
EOF

# -----------------------------------
$Lang{Pool_Stat} = <<EOF;
  <li>Pula to \${poolSize}GiB zawiera \$info->{"\${name}FileCnt"} plików oraz \$info->{"\${name}DirCnt"} katalogów (stan z \$poolTime),
  <li>Haszowanie puli daje \$info->{"\${name}FileCntRep"} powtarzających się plików z najdłuższym łańcuchem \$info->{"\${name}FileRepMax"},
  <li>Nocne czyszczenie usunęło \$info->{"\${name}FileCntRm"} plików o rozmiarze \${poolRmSize}GiB (około \$poolTime),
EOF

# --------------------------------
$Lang{BackupPC__Backup_Requested_on__host}              = "BackupPC: Kopia rządana na \$host";
$Lang{BackupPC__Delete_Requested_for_a_backup_of__host} = "BackupPC: Delete Requested for a backup of \$host";

# --------------------------------
$Lang{REPLY_FROM_SERVER} = <<EOF;
\${h1(\$str)}
<p>
Odpowiedź serwera to: \$reply
<p>
Wróć do <a href="\$MyURL?host=\$host">strony domowej \$host</a>.
EOF

# --------------------------------
$Lang{BackupPC__Start_Backup_Confirm_on__host} = "BackupPC: Potwierdzony start kopii na \$host";

# --------------------------------
$Lang{Are_you_sure_start} = <<EOF;
\${h1("Czy jesteś pewien?")}
<p>
Zamierzasz zacząć kopię \$type na \$host.
<form name="Confirm" action="\$MyURL" method="get">
  <input type="hidden" name="host" value="\$host">
  <input type="hidden" name="hostIP" value="\$ipAddr">
  <input type="hidden" name="doit" value="1">
  <input type="hidden" name="action" value="">
  Czy na pewno tego chcesz?
  <input type="button" value="\$buttonText" onClick="document.Confirm.action.value='\$In{action}'; document.Confirm.submit();">
  <input type="submit" value="No" name="ignore">
</form>
EOF

# --------------------------------
$Lang{BackupPC__Stop_Backup_Confirm_on__host} = "BackupPC: Zatrzymaj potwierdzoną kopię na \$host";

# --------------------------------
$Lang{Are_you_sure_stop} = <<EOF;
\${h1("Czy jesteś pewien?")}
<p>
Zamierzasz zatrzymać wykonywanie kopii na \$host;
<form name="Confirm" action="\$MyURL" method="get">
  <input type="hidden" name="host"   value="\$host">
  <input type="hidden" name="doit"   value="1">
  <input type="hidden" name="action" value="">
  Proszę nie zaczynać nowej kopii przez
  <input type="text" name="backoff" size="10" value="\$backoff"> godzin.
  <p>
  Czy na pewno tego chcesz?
  <input type="button" value="\$buttonText"
  onClick="document.Confirm.action.value='\$In{action}';
           document.Confirm.submit();">
  <input type="submit" value="No" name="ignore">
</form>
EOF

# --------------------------------
$Lang{Only_privileged_users_can_view_queues_} = "Tylko uprzywilejowani użytkownicy mogą przeglądać kolejki";

# --------------------------------
$Lang{Only_privileged_users_can_archive} = "Tylko uprzywilejowani użytkownicy mogą archiwizować.";

# --------------------------------
$Lang{BackupPC__Queue_Summary} = "BackupPC: Podsumowanie kolejki";

# --------------------------------
$Lang{Backup_Queue_Summary} = <<EOF;
\${h1("Podsumowanie kolejki kopii zapasowych")}
\${h2("Podsumowanie kolejki użytkownika")}
<p>
  Następujący użytkownicy są w kolejce:
</p>
<table class="tableStnd sortable tbl-User_Queue_Summary" border cellspacing="1" cellpadding="3" width="80%">
  <tr class="tableheader">
    <td>Host</td>
    <td>Akcja</td>
    <td>Czas do</td>
    <td>Użytkownik</td>
  </tr>
  \$strUser
</table>
\${h2("Podsumowanie kolejki w tle")}
<p>
  Następujące kolejki będące w tle czekają na wykonanie:
</p>
<table class="tableStnd sortable tbl-Background_Queue_Summary" border cellspacing="1" cellpadding="3" width="80%">
  <tr class="tableheader">
    <td>Host</td>
    <td>Akcja</td>
    <td>Czas do</td>
    <td>Użytkownik</td>
  </tr>
  \$strBg
</table>
\${h2("Podsumowanie kolejki poleceń")}
<p>
  Następujące kolejki poleceń czekają na wykonanie:
</p>
<table class="tableStnd sortable tbl-Command_Queue_Summary" border cellspacing="1" cellpadding="3" width="80%">
  <tr class="tableheader">
    <td>Host</td>
    <td>Akcja</td>
    <td>Czas do</td>
    <td>Użytkownik</td>
    <td>Polecenie</td>
  </tr>
  \$strCmd
</table>
EOF

# --------------------------------
$Lang{Backup_PC__Log_File__file} = "BackupPC: Plik \$file";
$Lang{Log_File__file__comment}   = <<EOF;
\${h1("Plik \$file \$comment")}
<p>
EOF

# --------------------------------
$Lang{Contents_of_log_file} = <<EOF;
Komentarze do pliku <tt>\$file</tt>, zmodyfikowne \$mtimeStr \$comment
EOF

# --------------------------------
$Lang{skipped__skipped_lines} = "[ pominięto \$skipped linii ]\n";

# --------------------------------
$Lang{_pre___Can_t_open_log_file__file} = "<pre>\nNie można otworzyć dziennika \$file\n";

# --------------------------------
$Lang{BackupPC__Log_File_History} = "BackupPC: Historia Dziennika";
$Lang{Log_File_History__hdr}      = <<EOF;
\${h1("Historia Dziennika \$hdr")}
<p>
<table class="tableStnd sortable tbl-Log_File_History" border cellspacing="1" cellpadding="3" width="80%">
  <tr class="tableheader">
    <td align="center">Plik</td>
    <td align="center">Rozmiar</td>
    <td align="center">Czas Modyfikacji</td>
  </tr>
  \$str
</table>
EOF

# -------------------------------
$Lang{Recent_Email_Summary} = <<EOF;
\${h1("Podsumowanie Emaili (kojeność odwrotna)")}
<p>
<table class="tableStnd sortable tbl-Recent_Email_Summary" border cellspacing="1" cellpadding="3" width="80%">
  <tr class="tableheader">
    <td align="center">Adresat</td>
    <td align="center">Nadawca</td>
    <td align="center">Czas</td>
    <td align="center">Temat</td>
  </tr>
  \$str
</table>
EOF

# ------------------------------
$Lang{Browse_backup__num_for__host} = "BackupPC: Przeglądaj \$num dla \$host";

# ------------------------------
$Lang{Restore_Options_for__host}  = "BackupPC: Przywróć opcje dla \$host";
$Lang{Restore_Options_for__host2} = <<EOF;
\${h1("Przywróć opcje dla \$host")}
<p>
Zaznaczyłeś następujące pliki/katalogi z
udziału \$share, kopia numer #\$num:
<ul>
  \$fileListStr
</ul>
</p>
<p>
Masz do wyboru trzy sposoby przywrócenia tych plików/katalogów. Proszę wybrać jeden z nich.
</p>
\${h2("Opcja Pierwsza: Bezpośrednie przywrócenie")}
<p>
EOF

$Lang{Restore_Options_for__host_Option1} = <<EOF;
Możesz zacząć przywracanie bezpośrednio na
<b>\$directHost</b>.
</p><p>
  <b>Uwaga:</b> jakikolwiek plik pasujący do tych które masz zaznaczone będzie nadpisany!
</p>
<form action="\$MyURL" method="post" name="direct">
  <input type="hidden" name="host" value="\${EscHTML(\$host)}">
  <input type="hidden" name="num" value="\$num">
  <input type="hidden" name="type" value="3">
  \$hiddenStr
  <input type="hidden" value="\$In{action}" name="action">
  <table class="tableStnd tbl-Restore_Option_1" border="0">
    <tr>
      <td>Przywrócenie plików na host</td>
      <td><!--<input type="text" size="40" value="\${EscHTML(\$host)}" name="hostDest">-->
      <select name="hostDest" onChange="document.direct.shareDest.value=''">
        \$hostDestSel
      </select>
      <script language="Javascript">
        function myOpen(URL) {
          window.open(URL,'','width=500,height=400');
        }
      </script>
      <!--<a href="javascript:myOpen('\$MyURL?action=findShares&host='+document.direct.hostDest.options.value)">Szukaj dostępnych udziałów (NIE ZAIMPLEMENTOWANE)</a>--></td>
    </tr>
    <tr>
      <td>Przywrócenie plików do udziału</td>
      <td><input type="text" size="40" value="\${EscHTML(\$share)}" name="shareDest"></td>
    </tr>
    <tr>
      <td>Przywróć pliki poniżej<br>(podobne do udziału)</td>
      <td valign="top"><input type="text" size="40" maxlength="256" value="\${EscHTML(\$pathHdr)}" name="pathHdr"></td>
    </tr>
    <tr>
      <td><input type="submit" value="Start Restore" name="ignore"></td>
    </tr>
  </table>
</form>
EOF

$Lang{Restore_Options_for__host_Option1_disabled} = <<EOF;
+Bezpośrednie przywrócenie na host zostało wcześniej wyłączone \${EscHTML(\$hostDest)}.
+Proszę wybrać inną opcję przywracania.
EOF

# ------------------------------
$Lang{Option_2__Download_Zip_archive} = <<EOF;
<p>
\${h2("Opcja Druga: Ściągnij Archiwum Zip")}
<p>
Możesz ściągnąć archiwum Zip zawierające wszystkie pliki/katalogi które zaznaczyłeś. Możesz wtedy użyć lokalnej aplikacji, takiej jak 7Zip, do przeglądania czy wypakowania danych.
</p>
<p>
<b>Uwaga:</b> zależnie od wybranych plików/katalogów, to archiwum może być bardzo duże. Może zajać dużo czasu stworzenie i przesłanie go. Będziesz również potrzebował odpowiedniej ilości miejsca na dysku do przechowania go.
</p>
<form action="\$MyURL" method="post">
  <input type="hidden" name="host" value="\${EscHTML(\$host)}">
  <input type="hidden" name="num" value="\$num">
  <input type="hidden" name="type" value="2">
  \$hiddenStr
  <input type="hidden" value="\$In{action}" name="action">
  <input type="checkbox" value="1" name="relative" checked> Stworzyć archiwum powiązane z \${EscHTML(\$pathHdr eq "" ? "/" : \$pathHdr)}
  (inaczej będzie zawierać pełne ścieżki do plików).
  <br>
  <table class="tableStnd tbl-Restore_Option_2" border="0">
    <tr>
      <td>Kompresja (0=wyłączona, 1=szybka,...,9=najlepsza)</td>
      <td><input type="text" size="6" value="5" name="compressLevel"></td>
    </tr>
    <tr>
      <td>Code page (e.g. cp866)</td>
      <td><input type="text" size="6" value="utf8" name="codePage"></td>
    </tr>
  </table>
  <br>
  <input type="submit" value="Ściągnij plik Zip" name="ignore">
</form>
EOF

# ------------------------------

$Lang{Option_2__Download_Zip_archive2} = <<EOF;
<p>
\${h2("Opcja Druga: Ściągnij Archiwum Zip")}
<p>
Archive::Zip nie jest zainstalowane więc nie możesz ściągnąć archiwum Zip. Proszę zgłosić administratorowi, żeby zainstalował Archive::Zip z <a href="http://www.cpan.org">www.cpan.org</a>.
</p>
EOF

# ------------------------------
$Lang{Option_3__Download_Zip_archive} = <<EOF;
\${h2("Opcja trzecia: Ściągnij archiwum Tar")}
<p>
Możesz ściągnąć archiwum Tar zawierające wszystkie pliki/katalogi które zaznaczyłeś. Możesz wtedy użyć lokalnej aplikacji, takiej jak 7Zip, do przeglądania czy wypakowania danych.
</p>
<p>
<b>Uwaga:</b> zależnie od wybranych plików/katalogów, to archiwum może być bardzo duże. Może zajać dużo czasu stworzenie i przesłanie go. Będziesz również potrzebował odpowiedniej ilości miejsca na dysku do przechowania go.
</p>
<form action="\$MyURL" method="post">
  <input type="hidden" name="host" value="\${EscHTML(\$host)}">
  <input type="hidden" name="num" value="\$num">
  <input type="hidden" name="type" value="1">
  \$hiddenStr
  <input type="hidden" value="\$In{action}" name="action">
  <input type="checkbox" value="1" name="relative" checked> Stworzyć archiwum powiązane z\${EscHTML(\$pathHdr eq "" ? "/" : \$pathHdr)}
  (inaczej będzie zawierać pełne ścieżki do plików).
  <br>
  <input type="submit" value="Ściągnij plik Tar" name="ignore">
</form>
EOF

# ------------------------------
$Lang{Restore_Confirm_on__host} = "BackupPC: Potwierdź przywrócenie na \$host";

$Lang{Are_you_sure} = <<EOF;
\${h1("Czy jesteś pewien?")}
<p>
Zaczynasz przywracanie bezpośrednio na maszynę \$In{hostDest}. Następujące pliki zostaną przywrócene na udział \$In{shareDest}, z kopii numer \$num:
<p>
<table class="tableStnd tbl-Restore-location" border>
<tr class="tableheader">
  <td>Orginalny plik/katalog</td>
  <td>Będzie przywrócony na</td>
  </tr>
  \$fileListStr
</table>
<form name="RestoreForm" action="\$MyURL" method="post">
  <input type="hidden" name="host" value="\${EscHTML(\$host)}">
  <input type="hidden" name="hostDest" value="\${EscHTML(\$In{hostDest})}">
  <input type="hidden" name="shareDest" value="\${EscHTML(\$In{shareDest})}">
  <input type="hidden" name="pathHdr" value="\${EscHTML(\$In{pathHdr})}">
  <input type="hidden" name="num" value="\$num">
  <input type="hidden" name="type" value="4">
  <input type="hidden" name="action" value="">
  \$hiddenStr
  Czy na pewno tego chcesz?
  <input type="button" value="\$Lang->{Restore}" onClick="document.RestoreForm.action.value='Restore'; document.RestoreForm.submit();">
  <input type="submit" value="No" name="ignore">
</form>
EOF

# --------------------------
$Lang{Restore_Requested_on__hostDest} = "BackupPC: Rządanie przywrócenia na \$hostDest";
$Lang{Reply_from_server_was___reply}  = <<EOF;
\${h1(\$str)}
<p>
Odpowiedź serwera: \$reply
<p>
Wróć na <a href="\$MyURL?host=\$hostDest">stronę domową \$hostDest</a>.
EOF

$Lang{BackupPC_Archive_Reply_from_server} = <<EOF;
\${h1(\$str)}
<p>
Odpowiedź serwera: \$reply
EOF

# --------------------------------
$Lang{BackupPC__Delete_Backup_Confirm__num_of__host} = "BackupPC: Delete Backup Confirm #\$num of \$host";

# --------------------------------
$Lang{A_filled}            = "a filled";
$Lang{An_unfilled}         = "an unfilled";
$Lang{Are_you_sure_delete} = <<EOF;
\${h1("Czy jesteś tego pewien?")}
<p>
You are about to delete \$filled \$type backup #\$num of \$host.

<form name="Confirm" action="\$MyURL" method="get">

<input type="hidden" name="host" value="\${EscHTML(\$host)}">
<input type="hidden" name="num" value="\$num">

<input type="hidden" name="doit" value="1">
<input type="hidden" name="action" value="">

Do you really want to do this?

<input type="button" value="\${EscHTML(\$Lang->{CfgEdit_Button_Delete})}"
 onClick="document.Confirm.action.value='deleteBackup';
          document.Confirm.submit();">

<input type="submit" value="No" name="ignore">
</form>
EOF

# -------------------------
$Lang{Host__host_Backup_Summary} = "BackupPC: Podsumowanie kopii zapasowych hosta \$host";

$Lang{Host__host_Backup_Summary2} = <<EOF;
\${h1("Podsumowanie kopii zapasowych hosta \$host")}
<p>
\$warnStr
<ul>
  \$statusStr
</ul>
</p>
\${h2("Działania użytkownika")}
<p>
<form name="StartStopForm" action="\$MyURL" method="get">
  <input type="hidden" name="host"   value="\$host">
  <input type="hidden" name="action" value="">
  \$startIncrStr
  <input type="button" value="\$Lang->{Start_Full_Backup}" onClick="document.StartStopForm.action.value='Start_Full_Backup'; document.StartStopForm.submit();">
  <input type="button" value="\$Lang->{Stop_Dequeue_Backup}" onClick="document.StartStopForm.action.value='Stop_Dequeue_Backup'; document.StartStopForm.submit();">
</form>
</p>
\${h2("Podsumowanie Kopii Zapasowych")}
<p>
Kliknij na numer kopii aby przeglądać i przywracać wybrane pliki/katalogi.
</p>
<table class="tableStnd sortable tbl-host_Backup_Summary-backup" border cellspacing="1" cellpadding="3">
  <tr class="tableheader">
    <td align="center">Nr kopii</td>
    <td align="center">Typ</td>
    <td align="center">Wypełniony</td>
    <td align="center">Poziom</td>
    <td align="center">Początek</td>
    <td align="center">Czas trwania (minuty)</td>
    <td align="center">Wiek (dni)</td>
    <td align="center">Trzymać</td>  <!-- TODO: improve this line -->
    \$deleteHdrStr
    <td align="center">Komentarz</td>
  </tr>
  \$str
</table>
<p>
  \$restoreStr
</p>
\${h2("Podsumowanie błędów Xfer")}
<table class="tableStnd sortable tbl-host_Backup_Summary-error" border cellspacing="1" cellpadding="3" width="80%">
  <tr class="tableheader">
    <td align="center">Nr kopii</td>
    <td align="center">Typ</td>
    <td align="center">Logi</td>
    <td align="center">Błędy Xfer</td>
    <td align="center">Błędne pliki</td>
    <td align="center">Błędne udziały</td>
    <td align="center">Błędy tar</td>
  </tr>
  \$errStr
</table>
\${h2("Liczba/wielkość użytych ponownie plików")}
<p>
Istniejące pliki to te będące aktualnie w puli. Nowe pliki to te dodane
do puli. Puste pliki i błędy SMB nie są liczone.
</p>
<table class="tableStnd sortable tbl-host_Backup_Summary-reuse" border cellspacing="1" cellpadding="3" width="80%">
  <tr class="tableheader">
    <td colspan="2" bgcolor="#ffffff"></td>
    <td align="center" colspan="3">Łącznie</td>
    <td align="center" colspan="2">Istniejące pliki</td>
    <td align="center" colspan="2">Nowe pliki</td>
  </tr>
  <tr class="tableheader sortheader">
    <td align="center">Nr kopii</td>
    <td align="center">Typ</td>
    <td align="center">Pliki</td>
    <td align="center">Rozmiar (MB)</td>
    <td align="center">MB/sek</td>
    <td align="center">Pliki</td>
    <td align="center">Rozmiar (MB)</td>
    <td align="center">Pliki</td>
    <td align="center">Rozmiar (MB)</td>
  </tr>
  \$sizeStr
</table>
\${h2("Podsumowanie Kompresji")}
<p>
Wydajność kompresji dla plików będących w puli oraz tych świeżo skompresowanych.
</p>
<table class="tableStnd sortable tbl-host_Backup_Summary-compression" border cellspacing="1" cellpadding="3" width="80%">
  <tr class="tableheader"><td colspan="3" bgcolor="#ffffff"></td>
    <td align="center" colspan="3">Istniejące Pliki</td>
    <td align="center" colspan="3">Nowe Pliki</td>
  </tr>
  <tr class="tableheader sortheader">
    <td align="center">Nr kopii</td>
    <td align="center">Typ</td>
    <td align="center">Poziom Kompresji</td>
    <td align="center">Rozmiar (MB)</td>
    <td align="center">Kompresja (MB)</td>
    <td align="center">Kompresja (%)</td>
    <td align="center">Rozmiar (MB)</td>
    <td align="center">Kompresja (MB)</td>
    <td align="center">Kompresja (%)</td>
  </tr>
  \$compStr
</table>
EOF

$Lang{Host__host_Archive_Summary}  = "BackupPC: Podsumowanie Archiwizacji hosta \$host";
$Lang{Host__host_Archive_Summary2} = <<EOF;
\${h1("Podsumowanie Archiwizacji hosta \$host")}
<p>
\$warnStr
<ul>
  \$statusStr
</ul>

\${h2("Działania Użytkownika")}
<p>
<form name="StartStopForm" action="\$MyURL" method="get">
  <input type="hidden" name="archivehost" value="\$host">
  <input type="hidden" name="host" value="\$host">
  <input type="hidden" name="action" value="">
  <input type="button" value="\$Lang->{Start_Archive}" onClick="document.StartStopForm.action.value='Start_Archive'; document.StartStopForm.submit();">
  <input type="button" value="\$Lang->{Stop_Dequeue_Archive}" onClick="document.StartStopForm.action.value='Stop_Dequeue_Archive'; document.StartStopForm.submit();">
</form>
\$ArchiveStr
EOF

# -------------------------
$Lang{Error}         = "BackupPC: Błąd";
$Lang{Error____head} = <<EOF;
\${h1("Błąd: \$head")}
<p>\$mesg</p>
EOF

# -------------------------
$Lang{NavSectionTitle_} = "Serwer";

# -------------------------
$Lang{Backup_browse_for__host} = <<EOF;
\${h1("Przeglądanie kopii dla \$host")}

<script language="javascript" type="text/javascript">
<!--

    function checkAll(location)
    {
      for (var i=0;i<document.form1.elements.length;i++)
      {
        var e = document.form1.elements[i];
        if ((e.checked || !e.checked) && e.name != \'all\') {
            if (eval("document.form1."+location+".checked")) {
                e.checked = true;
            } else {
                e.checked = false;
            }
        }
      }
    }

    function toggleThis(checkbox)
    {
       var cb = eval("document.form1."+checkbox);
       cb.checked = !cb.checked;
    }

//-->
</script>

<ul>
<li> Przegladasz kopię nr #\$num, która zaczęła się około \$backupTime (\$backupAge dni temu), \$filledBackup </li>
<li>
  <form name="formDir" method="post" action="\$MyURL">
    <input type="hidden" name="num" value="\$num">
    <input type="hidden" name="host" value="\$host">
    <input type="hidden" name="share" value="\${EscHTML(\$share)}">
    <input type="hidden" name="action" value="browse">
    Wpisz adres: <input type="text" name="dir" size="60" maxlength="4096" value="\${EscHTML(\$dir)}">
    <input type="submit" value="\$Lang->{Go}" name="Submit">
  </form>
<li>
  <form name="formComment" method="post" action="\$MyURL">
    <input type="hidden" name="num" value="\$num">
    <input type="hidden" name="host" value="\$host">
    <input type="hidden" name="share" value="\${EscHTML(\$share)}">
    <input type="hidden" name="action" value="browse">
    Komentarz: <input type="text" name="comment" class="inputCompact" size="60" maxlength="4096" value="\${EscHTML(\$comment)}">
    <input type="submit" value="\$Lang->{CfgEdit_Button_Save}" name="SetComment">
  </form>
<li>Wpisz adres aby przejść do niego,</li>
<li>Kliknij plik aby go przywrócić,</li>
<li>Możesz zobaczyć <a href="\$MyURL?action=dirHistory&host=\${EscURI(\$host)}&share=\$shareURI&dir=\$pathURI">historię kopii</a> obecnego adresu.</li>
\$share2pathStr
</ul>
</form>

\${h2("Zawartość \$dirDisplay")}
<form name="form1" method="post" action="\$MyURL">
  <input type="hidden" name="num" value="\$num">
  <input type="hidden" name="host" value="\$host">
  <input type="hidden" name="share" value="\${EscHTML(\$share)}">
  <input type="hidden" name="fcbMax" value="\$checkBoxCnt">
  <input type="hidden" name="action" value="Restore">
  <br>
  <table class="tbl-Backup_browse-contents" width="100%">
  <tr>
    <td valign="top" width="30%">
      <table class="tbl-Backup_browse-tree" align="left" border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff">
        \$dirStr
      </table>
    </td>
    <td width="3%"></td>
    <td valign="top">
      <br>
      <table class="tbl-Backup_browse-table" border width="100%" align="left" cellpadding="3" cellspacing="1">
        \$fileHeader
        \$topCheckAll
        \$fileStr
        \$checkAll
      </table>
    </td>
  </tr>
</table>
<br>
<!--
This is now in the checkAll row
<input type="submit" name="Submit" value="Restore selected files">
-->
</form>
EOF

$Lang{Browse_ClientShareName2Path} = <<EOF;
<li> Mapowanie nazwy udziału na ścieżkę rzeczywistego klienta (ClientShareName2Path):
    <ul>
\$share2pathStr
    </ul>
EOF

# ------------------------------
$Lang{DirHistory_backup_for__host} = "BackupPC: Historia kopii dla \$host";

#
# These two strings are used to build the links for directories and
# file versions. Files are appended with a version number.
#
$Lang{DirHistory_dirLink}  = "adres";
$Lang{DirHistory_fileLink} = "v";

$Lang{DirHistory_for__host} = <<EOF;
\${h1("Historia kopii dla \$host")}
<p>
Przedstawienie każdej unikalnej wersji każdego pliku we wszystkich kopiach:
<ul>
  <li>Kliknij na numerze kopii aby przejść do przegladania tejże kopii.</li>
  <li>Kliknij na adres (\$Lang->{DirHistory_dirLink}) aby przejść do niego.</li>
  <li>Kliknij na wersję pliku (\$Lang->{DirHistory_fileLink}0, \$Lang->{DirHistory_fileLink}1, ...) aby ściągnać ten plik.</li>
  <li>Pliki z tą samą zawartością pomiędzy różnymi kopiami mają ten sam numer wersji. (Wyjątek: pomiędzy kopiami w wersjach v3 oraz v4.)</li>
  <li>Pliki lub adresy, które nie są dostępne w określonej kopii nie są zaznaczone.</li>
  <li>Pliki pokazane z tą samą wersją mogą mieć inny atrybut. Wybierz numer kopii aby zobaczyć atrybuty plików.</li>
</ul>
\${h2("Historia \$dirDisplay")}
<br>
<table class="tbl-DirHistory" border cellspacing="2" cellpadding="3">
  <tr class="fviewheader">
    <td>Numer kopii</td>
    \$backupNumStr
  </tr>
  <tr class="fviewheader">
    <td>Czas trwania kopii</td>
    \$backupTimeStr
  </tr>
\$fileStr
</table>
EOF

# ------------------------------
$Lang{Restore___num_details_for__host} = "BackupPC: Przywróć #\$num detali dla \$host";

$Lang{Restore___num_details_for__host2} = <<EOF;
\${h1("Przywróć #\$num detali dla \$host")}
<p>
<table class="tableStnd tbl-Restore___num_details-details" border cellspacing="1" cellpadding="3" width="90%">
  <tr><td class="tableheader">Numer</td><td class="border">\$Restores[\$i]{num}</td></tr>
  <tr><td class="tableheader">Żądane przez</td><td class="border">\$RestoreReq{user}</td></tr>
  <tr><td class="tableheader">Czas żądania</td><td class="border">\$reqTime</td></tr>
  <tr><td class="tableheader">Wynik</td><td class="border">\$Restores[\$i]{result}</td></tr>
  <tr><td class="tableheader">Wiadomość błędu</td><td class="border">\$Restores[\$i]{errorMsg}</td></tr>
  <tr><td class="tableheader">Host źródłowy</td><td class="border">\$RestoreReq{hostSrc}</td></tr>
  <tr><td class="tableheader">Źródło kopii nr</td><td class="border">\$RestoreReq{num}</td></tr>
  <tr><td class="tableheader">Źródło udziału</td><td class="border">\$RestoreReq{shareSrc}</td></tr>
  <tr><td class="tableheader">Host docelowy</td><td class="border">\$RestoreReq{hostDest}</td></tr>
  <tr><td class="tableheader">Udział docelowy</td><td class="border">\$RestoreReq{shareDest}</td></tr>
  <tr><td class="tableheader">Czas rozpoczęcia</td><td class="border">\$startTime</td></tr>
  <tr><td class="tableheader">Czas trwania</td><td class="border">\$duration min</td></tr>
  <tr><td class="tableheader">Ilość plików</td><td class="border">\$Restores[\$i]{nFiles}</td></tr>
  <tr><td class="tableheader">Całkowity rozmiar</td><td class="border">\${MB} MB</td></tr>
  <tr><td class="tableheader">Szybkość transferu</td><td class="border">\$MBperSec MB/sec</td></tr>
  <tr><td class="tableheader">Błędy TarCreate</td><td class="border">\$Restores[\$i]{tarCreateErrs}</td></tr>
  <tr><td class="tableheader">Błędy Xfer</td><td class="border">\$Restores[\$i]{xferErrs}</td></tr>
  <tr>
    <td class="tableheader">Plik dziennika Xfer</td>
    <td class="border">
      <a href="\$MyURL?action=view&type=RestoreLOG&num=\$Restores[\$i]{num}&host=\$host">Widok</a>,
      <a href="\$MyURL?action=view&type=RestoreErr&num=\$Restores[\$i]{num}&host=\$host">Błędy</a>
    </td>
  </tr>
</table>
</p>
\${h1("Lista plików/katalogów")}
<p>
<table class="tableStnd tbl-Restore___num_details-fileList" border cellspacing="1" cellpadding="3" width="100%">
  <tr class="tableheader">
    <td>Orginalny plik/katalog</td>
    <td>Przywrócony na</td>
  </tr>
  \$fileListStr
</table>
EOF

# ------------------------------
$Lang{Archive___num_details_for__host} = "BackupPC: Szczegóły Archiwum nr #\$num dla \$host";

$Lang{Archive___num_details_for__host2} = <<EOF;
\${h1("Detale Archiwum nr #\$num dla \$host")}
<p>
<table class="tableStnd tbl-Archive___num_details-details" border cellspacing="1" cellpadding="3" width="80%">
  <tr><td class="tableheader">Numer</td><td class="border">\$Archives[\$i]{num}</td></tr>
  <tr><td class="tableheader">Żądane przez</td><td class="border">\$ArchiveReq{user}</td></tr>
  <tr><td class="tableheader">Czas żądania</td><td class="border">\$reqTime</td></tr>
  <tr><td class="tableheader">Wynik</td><td class="border">\$Archives[\$i]{result}</td></tr>
  <tr><td class="tableheader">Wiadomość błędu</td><td class="border">\$Archives[\$i]{errorMsg}</td></tr>
  <tr><td class="tableheader">Czas rozpoczęcia</td><td class="border">\$startTime</td></tr>
  <tr><td class="tableheader">Czas trwania</td><td class="border">\$duration min</td></tr>
  <tr>
    <td class="tableheader">Plik dziennika Xfer</td>
    <td class="border">
      <a href="\$MyURL?action=view&type=ArchiveLOG&num=\$Archives[\$i]{num}&host=\$host">Widok</a>,
      <a href="\$MyURL?action=view&type=ArchiveErr&num=\$Archives[\$i]{num}&host=\$host">Błędy</a>
    </td>
  </tr>
</table>
<p>
\${h1("Lista Hostów")}
<p>
<table class="tableStnd tbl-Archive___num_details-hostList" border cellspacing="1" cellpadding="3" width="80%">
<tr class="tableheader"><td>Host</td><td>Numer Kopii</td></tr>
\$HostListStr
</table>
EOF

# -----------------------------------
$Lang{Email_Summary} = "BackupPC: Podsumowanie emaili";

# -----------------------------------
#  !! ERROR messages !!
# -----------------------------------
$Lang{BackupPC__Lib__new_failed__check_apache_error_log} = "BackupPC::Lib->new failed: sprawdź apache error_log\n";
$Lang{Wrong_user__my_userid_is___} = "Zły użytkownik: mój userid to \$>, a nie \$uid(\$Conf{BackupPCUser})\n";

# $Lang{Only_privileged_users_can_view_PC_summaries} = "Tylko uprzywilejowani użytkownicy mogą przeglądać podsumowania.";
$Lang{Only_privileged_users_can_stop_or_start_backups} =
  "Tylko uprzywilejowani użytkownicy mogą dokonywać kopii na \${EscHTML(\$host)}.";
$Lang{Invalid_number__num}                         = "Zły numer \${EscHTML(\$In{num})}";
$Lang{Unable_to_open__file__configuration_problem} = "Nie można otworzyć \$file: problem z konfiguracją ?";
$Lang{Only_privileged_users_can_view_log_or_config_files} =
  "Tylko uprzywilejowani użytkownicy mogą przeglądać logi/pliki konf.";
$Lang{Only_privileged_users_can_view_log_files} = "Tylko uprzywilejowani użytkownicy mogą przeglądać logi.";
$Lang{Only_privileged_users_can_view_email_summaries} =
  "Tylko uprzywilejowani użytkownicy mogą przeglądać podsumowania emaili.";
$Lang{Only_privileged_users_can_browse_backup_files} =
  "Tylko uprzywilejowani użytkownicy mogą przeglądać pliki kopii for host \${EscHTML(\$In{host})}.";
$Lang{Only_privileged_users_can_delete_backups} =
  "Only privileged users can delete backups of host \${EscHTML(\$host)}.";
$Lang{Empty_host_name}                  = "Pusta nazwa hosta.";
$Lang{Directory___EscHTML}              = "Adres \${EscHTML(\"\$TopDir/pc/\$host/\$num\")} jest pusty";
$Lang{Can_t_browse_bad_directory_name2} = "Nie można przeglądać - zła nazwa \${EscHTML(\$relDir)}";
$Lang{Only_privileged_users_can_restore_backup_files} =
  "Tylko uprzywilejowani użytkownicy mogą przywracać pliki kopii dla hosta \${EscHTML(\$In{host})}.";
$Lang{Bad_host_name} = "Zła nazwa hosta \${EscHTML(\$host)}";
$Lang{You_haven_t_selected_any_files__please_go_Back_to} =
  "Nie zaznaczyłeś żadnych plików; proszę cofnąć się do zaznaczania plików.";
$Lang{You_haven_t_selected_any_hosts} = "Nie zaznaczyłeś żadnego hosta; proszę cofnij się i zaznacz odpowiednie hosty.";
$Lang{Nice_try__but_you_can_t_put}    = "Nieźle, ale nie możesz umieścić \'..\' w nazwie pliku";
$Lang{Host__doesn_t_exist}            = "Host \${EscHTML(\$In{hostDest})} nie istnieje";
$Lang{You_don_t_have_permission_to_restore_onto_host} =
  "Nie masz uprawnień do przywracania danych na host \${EscHTML(\$In{hostDest})}";
$Lang{Can_t_open_create__openPath} = "Nie można otworzyć/stworzyć\${EscHTML(\"\$openPath\")}";
$Lang{Only_privileged_users_can_restore_backup_files2} =
  "Tylko uprzywilejowani użytkownicy mogą przywracać pliki kopii dla hosta \${EscHTML(\$host)}.";
$Lang{Empty_host_name}      = "Pusta nazwa hosta";
$Lang{Unknown_host_or_user} = "Nieznany host albo użytkownik \${EscHTML(\$host)}";
$Lang{Only_privileged_users_can_view_information_about} =
  "Tylko uprzywilejowani użytkownicy mogą przeglądać informacje o host \${EscHTML(\$host)}.";
$Lang{Only_privileged_users_can_view_archive_information} =
  "Tylko uprzywilejowani użytkownicy mogą przeglądać informacje o archiwum.";
$Lang{Only_privileged_users_can_view_restore_information} =
  "Tylko uprzywilejowani użytkownicy mogą przeglądać przywracać informacje.";
$Lang{Restore_number__num_for_host__does_not_exist} =
  "Punkt przywracania nr \$num dla hosta \${EscHTML(\$host)} nie istnieje.";
$Lang{Archive_number__num_for_host__does_not_exist} =
  "Archiwum numer \$num dla hosta \${EscHTML(\$host)} nie istnieje.";
$Lang{Can_t_find_IP_address_for} = "Nie moge znaleść adresu IP dla \${EscHTML(\$host)}";
$Lang{host_is_a_DHCP_host}       = <<EOF;
\$host jest hostem DHCP, i dlatego nie znam jego IP. Sprawdziłem nazwę netbios \$ENV{REMOTE_ADDR}\$tryIP i dowiedziałem się, że ta maszyna to nie \$host.
<p>
+Dopóki nie zobaczę \$host pod danym adresem DHCP, możesz rozpocząć to żądanie tylko bezpośrednio z tejże maszyny.
EOF

# ------------------------------------
# !! Server Mesg !!
# ------------------------------------

$Lang{Backup_requested_on_DHCP__host} =
  "Kopia zażądana na hoście DHCP \$host (\$In{hostIP}) przez \$User z \$ENV{REMOTE_ADDR}";
$Lang{Backup_requested_on__host_by__User}        = "Kopia zażądana na \$host przez \$User";
$Lang{Backup_stopped_dequeued_on__host_by__User} = "Kopia przerwana na \$host przez \$User";
$Lang{Restore_requested_to_host__hostDest__backup___num} =
  "Przywrócenie na host \$hostDest, kopii nr #\$num, przez \$User z \$ENV{REMOTE_ADDR}";
$Lang{Delete_requested_for_backup_of__host_by__User} =
  "Delete requested for backup #\$num of \$host by \$User from \$ENV{REMOTE_ADDR}";
$Lang{Archive_requested} = "Archiwum żądane przez \$User z \$ENV{REMOTE_ADDR}";

# -------------------------------------------------
# ------- Stuff that was forgotten ----------------
# -------------------------------------------------

$Lang{Status}        = "Status";
$Lang{PC_Summary}    = "Podsumowanie hostów";
$Lang{LOG_file}      = "Plik Log";
$Lang{LOG_files}     = "Pliki Log";
$Lang{Old_LOGs}      = "Stare Logi";
$Lang{Email_summary} = "Podsumowanie emaili";
$Lang{Config_file}   = "Plik Konfiguracyjny";

# $Lang{Hosts_file} = "Plik Hostów";
$Lang{Current_queues} = "Aktualne kolejki";
$Lang{Documentation}  = "Dokumentacja";

#$Lang{Host_or_User_name} = "<small>Host lub nazwa użytkownika:</small>";
$Lang{Go}            = "Idź";
$Lang{Hosts}         = "Hosty";
$Lang{Select_a_host} = "Wybierz host...";

$Lang{There_have_been_no_archives}      = "<h2>Nie było żadnej archiwizacji</h2>\n";
$Lang{This_PC_has_never_been_backed_up} = "<h2>Ten PC nie był nigdy backupowany!!!</h2>\n";
$Lang{This_PC_is_used_by}               = "<li>Ten PC jest używany przez \${UserLink(\$user)}";

$Lang{Extracting_only_Errors} = "(Błędy wypakowywania)";
$Lang{XferLOG}                = "XferLOG";
$Lang{Errors}                 = "Błędy";

# ------------
$Lang{Last_email_sent_to__was_at___subject} = <<EOF;
<li>Ostatni email wysłany do \${UserLink(\$user)} był o \$mailTime, subject "\$subj".</li>
EOF

# ------------
$Lang{The_command_cmd_is_currently_running_for_started} = <<EOF;
<li>Polecenie \$cmd jest aktualnie wykonywane dla \$host, rozpoczęte o \$startTime.</li>
EOF

# -----------
$Lang{Host_host_is_queued_on_the_background_queue_will_be_backed_up_soon} = <<EOF;
<li>Host \$host jest zakolejkowany (kopia zostanie wykonana wkrótce).</li>
EOF

# ----------
$Lang{Host_host_is_queued_on_the_user_queue__will_be_backed_up_soon} = <<EOF;
<li>Host \$host jest zakolejkowany w kolejce użytkownika (kopia zostanie wykonana wkrótce).</li>
EOF

# ---------
$Lang{A_command_for_host_is_on_the_command_queue_will_run_soon} = <<EOF;
<li>Polecenie dla \$host jest w kolejce poleceń (ruszy wkrótce).</li>
EOF

# --------
$Lang{Last_status_is_state_StatusHost_state_reason_as_of_startTime} = <<EOF;
<li>Ostatni status \"\$Lang->{\$StatusHost{state}}\"\$reason od \$startTime.</li>
EOF

# --------
$Lang{Last_error_is____EscHTML_StatusHost_error} = <<EOF;
<li>Ostatni błąd to \"\${EscHTML(\$StatusHost{error})}\".</li>
EOF

# ------
$Lang{Pings_to_host_have_failed_StatusHost_deadCnt__consecutive_times} = <<EOF;
<li>Pingowanie \$host nie powidło się \$StatusHost{deadCnt} razy.</li>
EOF

# -----
$Lang{Prior_to_that__pings} = "Poprzednio, ";

# -----
$Lang{priorStr_to_host_have_succeeded_StatusHostaliveCnt_consecutive_times} = <<EOF;
<li>\$priorStr pingów do \$host zakończyło się sukcesem \$StatusHost{aliveCnt} razy.</li>
EOF

$Lang{Because__host_has_been_on_the_network_at_least__Conf_BlackoutGoodCnt_consecutive_times___} = <<EOF;
<li>Ponieważ \$host jest w sieci od co najmniej \$Conf{BlackoutGoodCnt} razy, nie zostanie utworzona kopia bezpieczeństwa \$blackoutStr.</li>
EOF

$Lang{__time0_to__time1_on__days} = "\$t0 to \$t1 on \$days";

$Lang{Backups_are_deferred_for_hours_hours_change_this_number} = <<EOF;
<li>Kopie zostały odłożone na \$hours godzin (<a href=\"\$MyURL?action=Stop_Dequeue_Backup&host=\$host\">zmień ten numer</a>).</li>
EOF

$Lang{tryIP} = " i \$StatusHost{dhcpHostIP}";

# $Lang{Host_Inhost} = "Host \$In{host}";

$Lang{checkAll} = <<EOF;
<tr>
  <td class="fviewborder">
    <input type="checkbox" name="allFiles" onClick="return checkAll('allFiles');">&nbsp;Select all
  </td>
  <td colspan="5" align="center" class="fviewborder">
    <input type="submit" name="Submit" value="Restore selected files">
  </td>
</tr>
EOF

$Lang{checkAllHosts} = <<EOF;
<tr>
  <td class="fviewborder">
    <input type="checkbox" name="allFiles" onClick="return checkAll('allFiles');">&nbsp;Select all
  </td>
  <td colspan="2" align="center" class="fviewborder">
    <input type="submit" name="Submit" value="Archive selected hosts">
  </td>
</tr>
EOF

$Lang{fileHeader} = <<EOF;
  <tr class="fviewheader"><td align=center> Nazwa</td>
    <td align="center">Typ</td>
    <td align="center">Tryb</td>
    <td align="center">Nr#</td>
    <td align="center">Rozmiar</td>
    <td align="center">Data modyfikacji</td>
  </tr>
EOF

$Lang{Home}                         = "Dom";
$Lang{Browse}                       = "Przeglądaj kopie";
$Lang{Last_bad_XferLOG}             = "Ostatni zły XferLOG";
$Lang{Last_bad_XferLOG_errors_only} = "Ostatni zły XferLOG (tylko błędy)";

$Lang{This_display_is_merged_with_backup} = <<EOF;
<li>ten display został złączony z kopią nr #\$numF.</li>
EOF

$Lang{Visit_this_directory_in_backup} = <<EOF;
<li>Wybierz kopię którą chcesz przeglądać: <select onChange="window.location=this.value">\$otherDirs </select></li>
EOF

$Lang{Restore_Summary} = <<EOF;
\${h2("Podsumowanie przywracania")}
<p>
Kliknij na numer przywrócenia dla informacji.
</p>
<table class="tableStnd sortable tbl-Restore_Summary" border cellspacing="1" cellpadding="3" width="80%">
  <tr class="tableheader">
    <td align="center">Nr przywr.</td>
    <td align="center">Wynik</td>
    <td align="center">Początek</td>
    <td align="center">Czas trwania (minuty)</td>
    <td align="center">Liczba plików</td>
    <td align="center">Rozmiar (MB)</td>
    <td align="center">Błędy tar</td>
    <td align="center">Błędy Xfer</td>
  </tr>
  \$restoreStr
</table>
<p>
EOF

$Lang{Archive_Summary} = <<EOF;
\${h2("Podsumowanie archiwum")}
<p>
Kliknij na numer archiwum po więcej informacji
<table class="tableStnd tbl-Archive_Summary" border cellspacing="1" cellpadding="3" width="80%">
  <tr class="tableheader">
    <td align="center">Nr archiwum</td>
    <td align="center">Wynik</td>
    <td align="right">Data początku</td>
    <td align="right">Czas trwania (minuty)</td>
  </tr>
  \$ArchiveStr
</table>
<p>
EOF

$Lang{BackupPC__Documentation} = "BackupPC: Dokumentacja";

$Lang{No}  = "nie";
$Lang{Yes} = "tak";

$Lang{The_directory_is_empty} = <<EOF;
<tr>
  <td bgcolor="#ffffff">Ten katalog jest \$dirDisplay pusty</td>
</tr>
EOF

#$Lang{on} = "wł";
$Lang{off} = "wył";

$Lang{backupType_full}    = "pełen";
$Lang{backupType_incr}    = "inkr";
$Lang{backupType_active}  = "active";
$Lang{backupType_partial} = "cząstkowy";

$Lang{failed}  = "nieudany";
$Lang{success} = "udany";
$Lang{and}     = "oraz";

# ------
# Hosts states and reasons
$Lang{Status_idle}                = "bezczynny";
$Lang{Status_backup_starting}     = "kopia w drodze";
$Lang{Status_backup_in_progress}  = "kopia w trakcie tworzenia";
$Lang{Status_restore_starting}    = "przywracanie w drodze";
$Lang{Status_restore_in_progress} = "przywracanie w trakcie tworzenia";
$Lang{Status_admin_pending}       = "link w trakcie";
$Lang{Status_admin_running}       = "link działa";

$Lang{Reason_backup_done}              = "zrobione";
$Lang{Reason_restore_done}             = "przywracanie zrobione";
$Lang{Reason_archive_done}             = "archiwum zrobione";
$Lang{Reason_nothing_to_do}            = "bezczynny";
$Lang{Reason_backup_failed}            = "kopia nieudana";
$Lang{Reason_restore_failed}           = "przywracanie nieudane";
$Lang{Reason_archive_failed}           = "archiwizacja nieudana";
$Lang{Reason_no_ping}                  = "nie ma pingu";
$Lang{Reason_backup_canceled_by_user}  = "kopia przerwana przez użytkownika";
$Lang{Reason_restore_canceled_by_user} = "przywracanie przerwane przez użytkownika";
$Lang{Reason_archive_canceled_by_user} = "archiwum przerwane przez użytkownika";
$Lang{Disabled_OnlyManualBackups}      = "automat wyłączony";
$Lang{Disabled_AllBackupsDisabled}     = "wyłączony";

# ---------
# Email messages

# No backup ever
$Lang{EMailNoBackupEverSubj} = "BackupPC: żadna kopia \$host nie powiodła się";
$Lang{EMailNoBackupEverMesg} = <<'EOF';
To: $user$domain
cc:
Subject: $subj
$headers
Drogi $userName,

Twój PC ($host) nigdy nie został zabezpieczony przez nasz program
tworzenia kopii zapasowych. Backup powinien nastąpić automatycznie
kiedy Twój PC zostanie podłączony do sieci. Powinieneś skontaktować się
z pomocą techniczną jeżeli:

  - Twój PC jest cały czas podłączony, co oznacza że występuje problem z konfiguracją
    uniemożliwiający tworzenie kopii.

  - Nie chcesz aby kopie były wykonywane i nie chcesz otrzymywać tych wiadomości.

Inaczej, proszę sprawdzić czy twój PC jest podłączony do sieci
nastepnym razem kiedy będziesz przy nim.

Pozdrawiam ,
Czarodziej BackupPC
https://backuppc.github.io/backuppc
EOF

# No recent backup
$Lang{EMailNoBackupRecentSubj} = "BackupPC: żadnych nowych kopii na \$host";
$Lang{EMailNoBackupRecentMesg} = <<'EOF';
To: $user$domain
cc:
Subject: $subj
$headers
Drogi $userName,

Twój PC ($host) nie był pomyślnie zarchiwizowany przez $days dni.
Twój PC był poprawnie zarchiwizowany $numBackups razy, od $firstTime do $days
temu. Wykonywanie kopii zapasowych powinno nastąpić automatycznie po
podłączeniu do sieci.

Jeżeli Twój PC był podłączony więcej niż kilka godzin do
sieci w czasie ostatnich $days dni powinieneś skontaktować sie z pomocą
techniczą czemu twoje kopie nie działają.

Inaczej, jeżeli jesteś poza miejscem pracy nie możesz zrobić więcej niż
skopiować samemu najważniejsze dane na odpowiedni nośnik.
Musisz wiedzieć że wszystkie pliki które stworzyłeś lub
zmieniłeś przez ostatnie $days dni (włącznie z nowymi emailami
i załącznikami) nie będą przywrócone jeżeli dysk ulegnie awarii.

Pozdrowienia,
Czarodziej BackupPC
https://backuppc.github.io/backuppc
EOF

# Old Outlook files
$Lang{EMailOutlookBackupSubj} = "BackupPC: Outlook files on \$host need to be backed up";
$Lang{EMailOutlookBackupMesg} = <<'EOF';
To: $user$domain
cc:
Subject: $subj
$headers
Dear $userName,

The Outlook files on your PC have $howLong.
These files contain all your email, attachments, contact and calendar
information.  Your PC has been correctly backed up $numBackups times from
$firstTime to $lastTime days ago.  However, Outlook locks all its files when
it is running, preventing these files from being backed up.

It is recommended you backup the Outlook files when you are connected
to the network by exiting Outlook and all other applications, and,
using just your browser, go to this link:

    $CgiURL?host=$host

Select "Start Incr Backup" twice to start a new incremental backup.
You can select "Return to $host page" and then hit "reload" to check
the status of the backup.  It should take just a few minutes to
complete.

Regards,
BackupPC Genie
https://backuppc.github.io/backuppc
EOF

$Lang{howLong_not_been_backed_up}               = "Utworzenie kopii nie zostało zakończone pomyślnie";
$Lang{howLong_not_been_backed_up_for_days_days} = "Kopia nie była tworzona od \$days dni";

#######################################################################
# RSS strings
#######################################################################
$Lang{RSS_Doc_Title}       = "Serwer BackupPC";
$Lang{RSS_Doc_Description} = "Kanał RSS dla BackupPC";
$Lang{RSS_Host_Summary}    = <<EOF;
Pełna Ilość: \$fullCnt;
Całkowita liczba/dni: \$fullAge;
Calkowity rozmiar/GiB: \$fullSize;
Prędkość MB/sek: \$fullRate;
Ilość Inkr: \$incrCnt;
Inkr wiek/Dni: \$incrAge;
Status: \$hostState;
Wyłączone: \$hostDisabled;
Ostatnia próba: \$hostLastAttempt;
EOF

#######################################################################
# Configuration editor strings
#######################################################################

$Lang{Only_privileged_users_can_edit_config_files} =
  "Tylko uprzywilejowani użytkownicy mogą edytować pliki konfiguracyjne.";
$Lang{CfgEdit_Edit_Config} = "Edytuj konfigurację";
$Lang{CfgEdit_Edit_Hosts}  = "Edytuj Hosty";

$Lang{CfgEdit_Title_Server}                    = "Serwer";
$Lang{CfgEdit_Title_General_Parameters}        = "Parametry Ogólne";
$Lang{CfgEdit_Title_Wakeup_Schedule}           = "Plan Pobudek";
$Lang{CfgEdit_Title_Concurrent_Jobs}           = "Prace Równoległe";
$Lang{CfgEdit_Title_Pool_Filesystem_Limits}    = "Limity puli systemu plików";
$Lang{CfgEdit_Title_Other_Parameters}          = "Inne Parametry";
$Lang{CfgEdit_Title_Remote_Apache_Settings}    = "Zdalne ustawienia Apache";
$Lang{CfgEdit_Title_Program_Paths}             = "Ścieżki Programów";
$Lang{CfgEdit_Title_Install_Paths}             = "Ścieżki Instalacji";
$Lang{CfgEdit_Title_Email}                     = "Email";
$Lang{CfgEdit_Title_Email_settings}            = "Ustawienia Email";
$Lang{CfgEdit_Title_Email_User_Messages}       = "Wiadomości Email do użytkowników";
$Lang{CfgEdit_Title_CGI}                       = "CGI";
$Lang{CfgEdit_Title_Admin_Privileges}          = "Prawa dostępu Admina";
$Lang{CfgEdit_Title_Page_Rendering}            = "Tworzenie strony";
$Lang{CfgEdit_Title_Paths}                     = "Ścieżki";
$Lang{CfgEdit_Title_User_URLs}                 = "URLe użytkownika";
$Lang{CfgEdit_Title_User_Config_Editing}       = "Edytowanie konfiguracji użytkownika";
$Lang{CfgEdit_Title_Xfer}                      = "Xfer";
$Lang{CfgEdit_Title_Xfer_Settings}             = "Ustawienia Xfer";
$Lang{CfgEdit_Title_Ftp_Settings}              = "Ustawienia FTP";
$Lang{CfgEdit_Title_Smb_Settings}              = "Ustawienia SMB";
$Lang{CfgEdit_Title_Tar_Settings}              = "Ustawienia Tar";
$Lang{CfgEdit_Title_Rsync_Settings}            = "Ustawienia Rsync";
$Lang{CfgEdit_Title_Rsyncd_Settings}           = "Ustawienia Rsyncd";
$Lang{CfgEdit_Title_Archive_Settings}          = "Ustawienia Archiwizacji";
$Lang{CfgEdit_Title_Include_Exclude}           = "Dodaj/Usuń";
$Lang{CfgEdit_Title_Smb_Paths_Commands}        = "Ścieżki/Polecenia SMB";
$Lang{CfgEdit_Title_Tar_Paths_Commands}        = "Ścieżki/Polecenia Tar";
$Lang{CfgEdit_Title_Rsync_Paths_Commands_Args} = "Ścieżki/Polecenia/Argumenty Rsync";
$Lang{CfgEdit_Title_Rsyncd_Port_Args}          = "Porty/Argumenty Rsyncds";
$Lang{CfgEdit_Title_Archive_Paths_Commands}    = "Ścieżki/PoleceniaArchive";
$Lang{CfgEdit_Title_Schedule}                  = "Harmonogram";
$Lang{CfgEdit_Title_Full_Backups}              = "Pełne Kopie";
$Lang{CfgEdit_Title_Incremental_Backups}       = "Kopie Inkrementalne";
$Lang{CfgEdit_Title_Blackouts}                 = "Przeciążenia";
$Lang{CfgEdit_Title_Other}                     = "Inne";
$Lang{CfgEdit_Title_Backup_Settings}           = "Ustawienia Kopii";
$Lang{CfgEdit_Title_Client_Lookup}             = "Sprawdzenie klienta";
$Lang{CfgEdit_Title_User_Commands}             = "Polecenia dla użytkownika";
$Lang{CfgEdit_Title_Hosts}                     = "Hosty";

$Lang{CfgEdit_Hosts_Comment} = <<EOF;
Aby dodać nowego hosta, zaznacz "Dodaj" i podaj jego nazwę. Aby
skopiowac ustawienia z innego hosta, wpisz nazwę hosta jako
NOWYHOST=KOPIOWANYHOST. Takie ustawienie spowoduje nadpisanie
konfiguracji dla NOWYHOST. Możesz zrobić to także dla istniejących
już hostów. Aby skasować hosta, po prostu naciśnij "Kasuj". "Dodaj", "Skasuj",
oraz kopia konfiguracji, nie zadziała dopóki nie naciśniesz "Zapisz".
Również żadna z usuniętych kopii hostów, więc jeżeli przypadkowo skasujesz coś czego nie chciałeś,
po prostu znowu ją dodaj. Aby całkowicie usunąć kopie zapasowe
danego hosta, musisz manualnie usunąć pliki z katalogu \$topDir/pc/HOST
EOF

$Lang{CfgEdit_Header_Main} = <<EOF;
\${h1("Główny Edytor Konfiguracji")}
EOF

$Lang{CfgEdit_Header_Host} = <<EOF;
\${h1("Edytor Konfiguracji Hosta \$host")}
<p>
Notka: Sprawdź opcję "Nadpisz" jeżeli chcesz zmienić wartość specificzną dla tego hosta.
<p>
EOF

$Lang{CfgEdit_Button_Save}      = "Zapisz";
$Lang{CfgEdit_Button_Insert}    = "Wstaw";
$Lang{CfgEdit_Button_Delete}    = "Kasuj";
$Lang{CfgEdit_Button_Add}       = "Dodaj";
$Lang{CfgEdit_Button_Override}  = "Nadpisz";
$Lang{CfgEdit_Button_New_Key}   = "Nowy Klucz";
$Lang{CfgEdit_Button_New_Share} = "New ShareName or '*'";

$Lang{CfgEdit_Error_No_Save}                            = "Błąd: Nie zapisano z powodu błędów";
$Lang{CfgEdit_Error__must_be_an_integer}                = "Błąd: \$var musi być liczbą całkowitą";
$Lang{CfgEdit_Error__must_be_real_valued_number}        = "Błąd: \$var musi być liczbą rzeczywistą";
$Lang{CfgEdit_Error__entry__must_be_an_integer}         = "Błąd: \$var wpis \$k musi być liczbą całkowitą";
$Lang{CfgEdit_Error__entry__must_be_real_valued_number} = "Błąd: \$var wpis \$k musi być liczbą rzeczywistą";
$Lang{CfgEdit_Error__must_be_executable_program} = "Błąd: \$var musi być poprawną ścieżką do programu wykonywalnego";
$Lang{CfgEdit_Error__must_be_valid_option}       = "Błąd: \$var musi być poprawną opcją";
$Lang{CfgEdit_Error_Copy_host_does_not_exist} =
  "Kopiowany host \$copyHost nie istnieje; tworzę nową nazwę \$fullHost. Skasuj ją jeżeli to nie jest to co chciałeś zrobić.";

$Lang{CfgEdit_Log_Copy_host_config}   = "Skopiowano konfigurację \$User z \$fromHost do \$host\n";
$Lang{CfgEdit_Log_Delete_param}       = "\$User skasowany \$p z \$conf\n";
$Lang{CfgEdit_Log_Add_param_value}    = "\$User dodany \$p do \$conf, ustawiono \$value\n";
$Lang{CfgEdit_Log_Change_param_value} = "\$User zmieniony \$p w \$conf na \$valueNew z \$valueOld\n";
$Lang{CfgEdit_Log_Host_Delete}        = "\$User skasował host \$host\n";
$Lang{CfgEdit_Log_Host_Change}        = "\$User z hosta \$host zmienił \$key z \$valueOld na \$valueNew\n";
$Lang{CfgEdit_Log_Host_Add}           = "\$User dodał host \$host: \$value\n";

#end of pl.pm
