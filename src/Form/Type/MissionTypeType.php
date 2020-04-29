<?php

declare(strict_types=1);

namespace App\Form\Type;

use App\Entity\MissionType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class MissionTypeType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('name', null, ['label' => 'organization.missionType.name'])
            ->add('minimumAvailableHours', IntegerType::class, [
                'label' => 'organization.planning.countMinimumAvailableHours.label',
                'help' => 'organization.planning.countMinimumAvailableHours.help',
                'required' => false,
                'attr' => [
                    'min' => 0,
                    'step' => 2,
                ],
            ])
            ->add('userSkillsRequirement', CollectionType::class, [
                'entry_type' => MissionTypeUserSkillsType::class,
                'allow_add' => true,
                'allow_delete' => true,
                'label' => 'organization.users',
            ])
            ->add('assetTypesRequirement', CollectionType::class, [
                'entry_type' => MissionTypeAssetTypesType::class,
                'allow_add' => true,
                'allow_delete' => true,
                'label' => 'organization.assets',
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => MissionType::class,
        ]);
    }
}
