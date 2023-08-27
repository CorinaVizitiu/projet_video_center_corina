<?php

namespace App\Form;

use App\Entity\Video;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

use Symfony\Component\Form\Extension\Core\Type\CheckboxType;
class VideoType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('title', null  , ['label' => 'Titre'])
            ->add('videoLink', null  , ['label' => 'Lien vidéo'])
            ->add('description')
            ->add('premiumVideo', CheckboxType::class, [
                'label' => 'Vidéo Reservé aux Membres  <span class="premium-star">&#9733;</span>',
                'label_html'=>true,
                'required' => false,
            ]);
       
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Video::class,
        ]);
    }
}
