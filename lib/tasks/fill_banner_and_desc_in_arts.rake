task fill_banner_and_desc_in_arts: :environment do
  a1 = Art.find_by(title: "Musique - Solo")
  if a1.present?
    a1.main_description = 'Un concert privé est toujours une expérience unique, un rapport brut et authentique entre l’artiste, son œuvre et le public. Tous nos musiciens sont professionnels et jouent en liveleurs propres compositions.'
    a1.italic_description = 'Le jour de votre événement, l’artiste arriveraun peu en avance avec son propre matériel et se chargera de l’installa.'
    a1.banner_url = 'https://photos-1.dropbox.com/t/2/AACeck62zufwAqtp-ShbYV6TeZoexP8blwiaOLYhqvC4ug/12/101242233/png/32x32/3/1464865200/0/2/B-musique.png/EIzQuU4Yg9UGIAIoAg/tePLP3bVo2jYMsH0IHgRiLpqsA7lKtBprm8ObC-M6Uk?size_mode=3&size=2048x1536'
    a1.save
  end
    
  a2 = Art.find_by(title: "Musique - Duo & Groupe")
  if a2.present?
    a2.main_description = 'Un concert privé est toujours une expérience unique, un rapport brut et authentique entre le groupe, son œuvre et le public. Tous nos musiciens sont professionnels et jouent en live leurs propres compositions.'
    a2.italic_description = 'Le jour de votre événement, le groupearrivera un peu en avance avec son propre matériel et se chargera de l’insta.'
    a2.banner_url = 'https://photos-1.dropbox.com/t/2/AACeck62zufwAqtp-ShbYV6TeZoexP8blwiaOLYhqvC4ug/12/101242233/png/32x32/3/1464865200/0/2/B-musique.png/EIzQuU4Yg9UGIAIoAg/tePLP3bVo2jYMsH0IHgRiLpqsA7lKtBprm8ObC-M6Uk?size_mode=3&size=2048x1536'
    a2.save
  end
    
  a3 = Art.find_by(title: "Oenologie")
  if a3.present?
    a3.main_description = 'Quelle que soit votre expérience avec le vin, invitez quelques amis et installez-vous confortablement dans votre canapé. Initiations ou thématiques, nos œnologues professionnels vous proposent des dégustations ludiques de vins sélectionnés pour l’occasion.'
    a3.italic_description = 'Le jour J, vous n’avez rien à préparer. L’œnologue que vous aurez choisi apporte les bouteilles, les verres de dégustation et peut-êtremêmeune petite surprise gourmande!'
    a3.banner_url = 'https://photos-3.dropbox.com/t/2/AACfKf5lPzLCWn9b8MSRKv5LIqCfI_2qdBkgN3Aq2rVFmQ/12/101242233/png/32x32/3/1464865200/0/2/B-oenologie.png/EIzQuU4Yg9UGIAIoAg/qc6l2fzkK3SUCb-1VLqWOMTc56DbRyNONXIgsg9KLFQ?size_mode=3&size=2048x1536'
    a3.save
  end
    
  a4 = Art.find_by(title: "Insolite")
  if a4.present?
    a4.main_description = 'Pour ceux qui n’ont pas froid aux yeux. Magie close-up, mentalisme, hypnose... L’occasion d’essayer, enfin. Nous les avons tous vus à l’œuvre et croyez-nous, ils mettront à malvos certitudes et challengerontvotre perception de.'
    a4.italic_description = 'Le jour J, le performeur que vous aurez choisi apporte sa valise de matériel, mais il pourra aussi utiliser ce qu’il trouve autour de lui. Soyez prêteur!'
    a4.banner_url = 'https://photos-5.dropbox.com/t/2/AABTog-nbZwO5jGoC7NTpVTlQIwkgVPalZszLOmfEzyFGw/12/101242233/png/32x32/3/1464868800/0/2/B-insolite.png/EIzQuU4Yg9UGIAIoAg/uCa6_UKIpWB3sGNmNYty0G2nje8XB8dMaTo4VZjow5w?size_mode=3&size=2048x1536'
    a4.save
  end

  a5 = Art.find_by(title: "Photographie")
  if a5.present?
    a5.main_description = 'Vous l’aurez compris, En apparté met en avant la création. Nous avons donc sélectionné des photographes ayant une sensibilité artistiquequi nous touche, et un goût du travail bien fait. Vivez vos évènements, et laissez à des professionnels le soin de les rendre éternels.'
    a5.banner_url = 'https://photos-5.dropbox.com/t/2/AAC2QWbkvGEAdBoWrtG7c-OdG3mxrVH2ZC8elgkyF7jdRg/12/101242233/png/32x32/3/1464868800/0/2/B-photographie.png/EIzQuU4Yg9UGIAIoAg/uirjRlq7Y7sSQCXcSBOmR0rOtKwkVYNxospHYy57Ou8?size_mode=3&size=2048x1536'
    a5.save
  end

  a6 = Art.find_by(title: "Gastronomie")
  if a6.present?
    a6.main_description = 'Issus d’excellentes Maisons, nos chefs à domicile mettent leur savoir-faire et leur sensibilité au service de votre événement. Ils vont ont concocté des menus d’exception, qu’ils préparent dans votre cuisine avant d’assurer le service à table. Plus besoin d’aller au restaurant.'
    a6.italic_description = 'Le jour J, le chef s’occupe de tout: achat des ingrédients, cuisine, service à table et rangement.'
    a6.banner_url = 'https://photos-1.dropbox.com/t/2/AADAxbSEuob_mSmc4PCiJyxpMeig74I0xX1dJYUTNkCh_A/12/101242233/png/32x32/3/1464868800/0/2/B-Gastronomie.png/EIzQuU4Yg9UGIAIoAg/z69206FuWIhMZvNAPBE1J9T-C8NtTCcQ1MtFq1V5F90?size_mode=3&size=2048x1536'
    a6.save
  end

  a7 = Art.find_by(title: "Spectacle vivant")
  if a7.present?
    a7.main_description = 'Théâtre, improvisation, stand-up... Deux fauteuils à déplacer, et votre chez-vous se mue en salle de spectacle. Nos comédiens professionnels appréhendent l’espace,et la proximité avec le public donne une dimension nouvelle à leur art.'
    a7.italic_description = 'Quelques mètres carrés suffisent, quel que soit le spectacle que vous aurez choisi. Les comédiens ont spécialement calibré leur propositionpour la sphère privée, ils n’utilisent donc pas (ou pas) de matériel'
    a7.banner_url = 'https://photos-2.dropbox.com/t/2/AABkxBSfvQ-EbDEFwEBQckZzKNBw9tI86s5RLoDwZE6PRg/12/101242233/png/32x32/3/1464868800/0/2/B-spectacle_vivant.png/EIzQuU4Yg9UGIAIoAg/Xz_byNZ8VfLxcjz0mdnSmPFp5OJ4dbk43o48Uo55nRQ?size_mode=3&size=2048x1536'
    a7.save
  end

  a8 = Art.find_by(title: "Live painting")
  if a8.present?
    a8.main_description = 'Peindre en live devant un public est un challenge stimulant, un processus créatif à part. Cela ne s’improvise pas. Nos artistespeintressont passés maîtres dans cet art,et ont déjà souvent abandonné, le temps d’un événement, le confort de leur atelier. Assistez à la naissance d’une œuvre, qui sera peut-être vôtre à la fin de la soirée!'
    a8.italic_description = 'Nos artistes n’en sont pas à leurs débuts avec la peinture live. Leurs techniques sont adaptées au contexte et ilsapportent le matériel adéquat(y compris les toiles de protection si nécessaire).'
    a8.banner_url = 'https://photos-2.dropbox.com/t/2/AADGRkTnYow8Qsoka_O0hMWtDEgVl8eYm-SWXlOGdPHcFQ/12/101242233/png/32x32/3/1464868800/0/2/B-Live_painting.png/EIzQuU4Yg9UGIAIoAg/KPVgIDPJGTs9HYOMseqelnzDg31b53xsLZIa91h72og?size_mode=3&size=2048x1536'
    a8.save
  end
end
