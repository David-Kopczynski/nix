{ ... }:

{
  boot.plymouth.enable = true;

  # Silent boot
  boot.consoleLogLevel = 3;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "quiet"
    "rd.udev.log_level=3"
    "rd.systemd.show_status=auto"
  ];

  # Hide generations
  boot.loader.timeout = 0;
}
