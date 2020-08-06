import {Component, OnInit} from '@angular/core';
import {HttpClient} from '@angular/common/http';
import { environment } from '../environments/environment';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent implements OnInit{
  text = '';

  constructor(private http: HttpClient) {}


  ngOnInit(): void {

  }

  click() {
    console.log(environment)
    this.http.get('http://' + environment.apiBaseUrl + 'text', {responseType: 'text'})
      .toPromise()
      .then((res) => {
          this.text = res;
      }, e => { this.text = 'Oops, service must not be working.'; });
  }
}
