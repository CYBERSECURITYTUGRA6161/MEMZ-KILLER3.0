MEMZKiller Recovery

> A small Windows Recovery Environment (WinRE) helper for repairing common boot-record damage after destructive test malware. It is intended for virtual machines and lab use.

## What it does

MEMZKiller Recovery runs the following built-in Windows `bootrec` commands after an explicit confirmation:

```bat
bootrec /fixmbr
bootrec /fixboot
bootrec /rebuildbcd
```

These commands attempt to restore the master boot record (MBR), boot sector, and Boot Configuration Data (BCD). This can remove a damaged MBR boot payload, such as the Nyan Cat screen associated with destructive MEMZ variants, so that Windows can boot again.

## What it does **not** do

- It does not detect or remove malware from a running Windows installation.
- It does not stop MEMZ before it writes to the disk.
- It does not recover files, remove persistence, or guarantee that a damaged installation is safe.
- It is not a replacement for Microsoft Defender, backups, a VM snapshot, or a clean reinstall.
- It does not support UEFI recovery automatically. On UEFI systems, `bootrec /fixboot` may return **Access is denied** and the EFI boot files may need to be rebuilt with `bcdboot` instead.

## Included files

| File | Purpose |
| --- | --- |
| `MEMZKiller-Recovery.cmd` | The recommended command-script version. It works directly from the WinRE Command Prompt. |
| `MEMZKiller-Recovery.exe` | A small confirmation-based GUI wrapper for environments where the required .NET runtime is available. |

## Important safety warning

Run this project **only inside Windows Recovery Environment (WinRE)**. Do not run it in a normal Windows session or on a host computer just to test it.

The tool changes boot records. Although it does not intentionally delete personal files, boot repair is an advanced recovery operation. Back up important data first whenever possible.

For malware experiments, use a disposable virtual machine with:

- a clean snapshot created before the test;
- networking disabled;
- shared folders, shared clipboard, drag-and-drop, and USB passthrough disabled.

Restoring the clean VM snapshot is safer and more reliable than attempting repair after a destructive payload has run.

## Usage

1. Boot the affected test VM from a Windows installation or recovery USB.
2. Select **Repair your computer**.
3. Go to **Troubleshoot → Advanced options → Command Prompt**.
4. Copy `MEMZKiller-Recovery.cmd` to removable media and run it from that Command Prompt.
5. Type `ONAR` when asked to confirm.
6. Read each command result carefully.
7. Remove the recovery media and restart the VM.

If `bootrec /rebuildbcd` finds a Windows installation, choose the option to add it to the boot list.

## Troubleshooting

### `bootrec /fixboot` returns “Access is denied”

This is common on UEFI/GPT systems. Do not repeatedly run random repair commands. Identify and mount the EFI System Partition, then use `bcdboot` with the correct Windows and EFI partition letters. Microsoft documents the UEFI/BCD recovery workflow here: <https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/repair-the-boot-menu-on-a-dual-boot-pc?view=windows-11>.

### Windows still does not start

The damage may extend beyond the boot record, or the malware may still be present. Restore a known-good VM snapshot, use a clean backup, or reinstall Windows in the test VM. Do not treat a successful boot as proof that the system is malware-free.

## Responsible use

This project is a recovery helper, not malware and not an “antivirus that defeats MEMZ.” Do not use it to alter systems you do not own or administer. Keep destructive malware experiments isolated to disposable virtual machines.

## License

Choose a license before publishing. The MIT License is a common simple choice for a small utility like this.

