<?php

namespace App\Controller\Admin;

use App\Entity\Platforme;
use App\Enum\TypeMedia;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\ChoiceField;
use EasyCorp\Bundle\EasyAdminBundle\Field\IdField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;

class PlatformeCrudController extends AbstractCrudController
{
    public static function getEntityFqcn(): string
    {
        return Platforme::class;
    }

    public function configureFields(string $pageName): iterable
    {
        return [
            IdField::new('id')->hideOnForm(),
            ChoiceField::new('name', 'Plateforme')
                ->setChoices(array_combine(
                    array_map(fn($case) => $case->value, TypeMedia::cases()),
                    TypeMedia::cases()
                )),
            TextField::new('url', 'URL'),
            TextField::new('logo', 'Logo')->hideOnIndex(),
        ];
    }
}
