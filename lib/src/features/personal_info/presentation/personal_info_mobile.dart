import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfolio/src/constants/sizes.dart';
import 'package:portfolio/src/features/personal_info/data/personal_info_repository.dart';
import 'package:portfolio/src/features/personal_info/domain/resume.dart';
import 'package:portfolio/src/features/personal_info/presentation/widgets/contact_bar.dart';
import 'package:portfolio/src/features/personal_info/presentation/widgets/resume_button.dart';
import 'package:portfolio/src/localization/generated/locale_keys.g.dart';

class PersonalInfoMobile extends ConsumerWidget {
  const PersonalInfoMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resumes = ref.watch(personalInfoRepositoryProvider).getResumes();
    final contacts = ref.watch(personalInfoRepositoryProvider).getContacts();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- BAGIAN FOTO PROFIL (Versi Mobile) ---
        Center(
          child: Container(
            width: 130, // Sedikit lebih kecil dari Desktop (140 -> 130)
            height: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 3, // Border sedikit lebih tipis
              ),
              image: const DecorationImage(
                // Pastikan nama file sesuai aset Anda
                image: AssetImage('assets/images/mochtar.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        gapH16,
        // --- AKHIR FOTO PROFIL ---

        Text(
          tr(LocaleKeys.name),
          // Ukuran font 32 biasanya paling pas untuk nama panjang di HP
          style:
              Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 32),
        ),
        gapH4,
        Text(
          tr(LocaleKeys.description),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
        ),
        gapH8,
        Text(
          tr(LocaleKeys.subDescription),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        _buildResumeButton(ref, resumes: resumes.toList()),
        gapH8,
        ContactBar(contacts: contacts.toList()),
      ],
    );
  }

  Widget _buildResumeButton(WidgetRef ref, {required List<Resume> resumes}) {
    if (resumes.isEmpty) return const SizedBox.shrink();
    return Padding(
      // Jarak diperkecil dari 28 ke 16 agar hemat tempat di layar kecil
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ResumeButton(resumes: resumes),
    );
  }
}
