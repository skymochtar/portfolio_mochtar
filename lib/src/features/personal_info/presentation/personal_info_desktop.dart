import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfolio/src/constants/sizes.dart';
import 'package:portfolio/src/features/personal_info/data/personal_info_repository.dart';
import 'package:portfolio/src/features/personal_info/domain/resume.dart';
import 'package:portfolio/src/features/personal_info/presentation/widgets/contact_bar.dart';
import 'package:portfolio/src/features/personal_info/presentation/widgets/resume_button.dart';
import 'package:portfolio/src/localization/generated/locale_keys.g.dart';

class PersonalInfoDesktop extends ConsumerWidget {
  const PersonalInfoDesktop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resumes = ref.watch(personalInfoRepositoryProvider).getResumes();
    final contacts = ref.watch(personalInfoRepositoryProvider).getContacts();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- FOTO PROFIL (Ukuran disesuaikan jadi 140 biar muat) ---
        Center(
          child: Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 4,
              ),
              image: const DecorationImage(
                // Pastikan nama file sesuai dengan yang di folder assets
                image: AssetImage('assets/images/mochtar.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        gapH16, // Jarak diperkecil (tadinya gapH24)

        // --- NAMA & JABATAN ---
        Text(
          tr(LocaleKeys.name),
          style:
              Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 41),
        ),
        gapH4,
        Text(
          tr(LocaleKeys.description),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        gapH8,
        Text(
          tr(LocaleKeys.subDescription),
          style: Theme.of(context).textTheme.bodyLarge,
        ),

        // --- TOMBOL RESUME ---
        _buildResumeButton(ref, resumes: resumes.toList()),

        const Spacer(), // Spacer ini akan mendorong icon ke paling bawah

        // --- CONTACT ICONS ---
        gapH8,
        ContactBar(contacts: contacts.toList()),
      ],
    );
  }

  // FUNGSI INI SUDAH DIHEMAT SPASINYA:
  Widget _buildResumeButton(WidgetRef ref, {required List<Resume> resumes}) {
    if (resumes.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(vertical: 6), // Diubah dari 24 jadi 12
          child: ResumeButton(resumes: resumes),
        ),
      ],
    );
  }
}
