import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AdministrationComponent } from '../components/administration/administration.component';
import { UsersComponent } from '../components/users/users.component';
import { ChallengesComponent } from '../components/challenges/challenges.component';

const routes: Routes = [
        { path: 'admin', component: AdministrationComponent},
        { path: 'users', component: UsersComponent},
        { path: 'challenges', component: ChallengesComponent},
    ];

@NgModule({
        imports: [
            RouterModule.forRoot(routes)
        ],
        exports: [
            RouterModule
        ],
        declarations: []
    })
    export class AppRoutingModule { }
