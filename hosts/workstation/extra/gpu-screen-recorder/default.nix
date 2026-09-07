{ ... }:

{
  home-manager.users."user" = { ... }: {

    # Basic configuration
    xdg.configFile."gpu-screen-recorder/config_ui".text = ''

      # Disable all hotkeys
      record.pause_unpause_hotkey 0 0
      record.start_stop_hotkey 0 0
      record.start_stop_region_hotkey 0 0
      record.start_stop_window_hotkey 0 0
      replay.save_10_min_hotkey 0 0
      replay.save_1_min_hotkey 0 0
      replay.save_hotkey 0 0
      replay.start_stop_hotkey 0 0
      screenshot.take_screenshot_hotkey 0 0
      screenshot.take_screenshot_region_hotkey 0 0
      screenshot.take_screenshot_window_hotkey 0 0
      streaming.start_stop_hotkey 0 0

      # Configure replay
      replay.time 600
      replay.turn_on_replay_automatically_mode turn_on_at_system_startup

      # Select target monitor
      record.record_options.record_area_option DP-2
      replay.record_options.record_area_option DP-2
      streaming.record_options.record_area_option DP-2
    '';
  };
}
