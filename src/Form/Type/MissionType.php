<?php

declare(strict_types=1);

namespace App\Form\Type;

use App\Entity\Mission;
use App\Entity\MissionType as MissionTypeEntity;
use App\Entity\Organization;
use App\Repository\MissionTypeRepository;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\DateTimeType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class MissionType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $organization = $builder->getData()->organization ?? null;
        if (!$organization instanceof Organization || null === $organization->id) {
            throw new \InvalidArgumentException('Mission form must be initialized with an already persisted organization');
        }

        $builder
            ->add('name', null, ['label' => 'organization.mission.name'])
            ->add('type', EntityType::class, [
                'label' => 'common.type',
                'class' => MissionTypeEntity::class,
                'query_builder' => static function (MissionTypeRepository $repository) use ($organization) {
                    return $repository->findByOrganizationQb($organization);
                },
                'choice_label' => 'name',
                'required' => false,
            ])
            ->add('start', DateTimeType::class, [
                'widget' => 'single_text',
                'input' => 'datetime_immutable',
                'label' => 'common.start',
                'required' => false,
            ])
            ->add('end', DateTimeType::class, [
                'widget' => 'single_text',
                'input' => 'datetime_immutable',
                'label' => 'common.end',
                'required' => false,
            ]);
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Mission::class,
        ]);
    }
}
