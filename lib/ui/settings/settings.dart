import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingTab extends StatefulWidget {
  const SettingTab({super.key});

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  bool _darkMode = true;
  bool _notifications = true;
  bool _autoDownload = false;
  bool _highQuality = true;
  double _volume = 0.8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Profile Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      CupertinoIcons.person_fill,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Music Lover',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Premium Member',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    CupertinoIcons.chevron_right,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Playback Settings
            const Text(
              'Playback',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSettingSection([
              _buildSliderSetting(
                'Volume',
                CupertinoIcons.speaker_3,
                _volume,
                (value) => setState(() => _volume = value),
              ),
              _buildSwitchSetting(
                'High Quality Audio',
                CupertinoIcons.hifispeaker,
                _highQuality,
                (value) => setState(() => _highQuality = value),
              ),
              _buildNavigationSetting(
                'Equalizer',
                CupertinoIcons.slider_horizontal_3,
                'Customize your sound',
              ),
              _buildNavigationSetting(
                'Crossfade',
                CupertinoIcons.shuffle,
                '5 seconds',
              ),
            ]),
            const SizedBox(height: 30),

            // Download Settings
            const Text(
              'Downloads',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSettingSection([
              _buildSwitchSetting(
                'Auto Download',
                CupertinoIcons.cloud_download,
                _autoDownload,
                (value) => setState(() => _autoDownload = value),
              ),
              _buildNavigationSetting(
                'Download Quality',
                CupertinoIcons.arrow_down_circle,
                'High',
              ),
              _buildNavigationSetting(
                'Storage Location',
                CupertinoIcons.folder,
                'Internal Storage',
              ),
            ]),
            const SizedBox(height: 30),

            // Notifications
            const Text(
              'Notifications',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSettingSection([
              _buildSwitchSetting(
                'Push Notifications',
                CupertinoIcons.bell,
                _notifications,
                (value) => setState(() => _notifications = value),
              ),
              _buildNavigationSetting(
                'New Music',
                CupertinoIcons.music_note_2,
                'Weekly',
              ),
              _buildNavigationSetting(
                'Artist Updates',
                CupertinoIcons.person_2,
                'Enabled',
              ),
            ]),
            const SizedBox(height: 30),

            // Appearance
            const Text(
              'Appearance',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSettingSection([
              _buildSwitchSetting(
                'Dark Mode',
                CupertinoIcons.moon,
                _darkMode,
                (value) => setState(() => _darkMode = value),
              ),
              _buildNavigationSetting(
                'Theme Color',
                CupertinoIcons.paintbrush,
                'Purple',
              ),
              _buildNavigationSetting(
                'Display',
                CupertinoIcons.device_phone_portrait,
                'Auto-rotate',
              ),
            ]),
            const SizedBox(height: 30),

            // Support & Legal
            const Text(
              'Support & Legal',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSettingSection([
              _buildNavigationSetting(
                'Help Center',
                CupertinoIcons.question_circle,
                '',
              ),
              _buildNavigationSetting(
                'Contact Support',
                CupertinoIcons.chat_bubble,
                '',
              ),
              _buildNavigationSetting(
                'Privacy Policy',
                CupertinoIcons.doc_text,
                '',
              ),
              _buildNavigationSetting(
                'Terms of Service',
                CupertinoIcons.doc_checkmark,
                '',
              ),
            ]),
            const SizedBox(height: 30),

            // App Info
            Center(
              child: Column(
                children: [
                  Text(
                    'Spong Music',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingSection(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2A2A2A)),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSwitchSetting(String title, IconData icon, bool value, Function(bool) onChanged) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF6366F1), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          CupertinoSwitch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF6366F1),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderSetting(String title, IconData icon, double value, Function(double) onChanged) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: const Color(0xFF6366F1), size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                '${(value * 100).round()}%',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: const Color(0xFF6366F1),
              inactiveTrackColor: const Color(0xFF2A2A2A),
              thumbColor: const Color(0xFF6366F1),
              overlayColor: const Color(0xFF6366F1).withOpacity(0.2),
            ),
            child: Slider(
              value: value,
              onChanged: onChanged,
              min: 0.0,
              max: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationSetting(String title, IconData icon, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF6366F1), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const Icon(
            CupertinoIcons.chevron_right,
            color: Colors.grey,
            size: 16,
          ),
        ],
      ),
    );
  }
}
