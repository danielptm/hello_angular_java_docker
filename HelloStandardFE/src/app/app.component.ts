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
  text2 = '';

  constructor(private http: HttpClient) {}


  ngOnInit(): void {

  }

  click() {
    // svc 1 endpoint
    let svc_1_endpoint = environment.local === true ? 'http://' + environment.apiBaseUrl + ":" + environment.api_gateway_port + '/text' : 'http://localhost:5000/text' ;
    this.http.get(svc_1_endpoint, {responseType: 'text'})
      .toPromise()
      .then((res) => {
          this.text = res;
      }, e => { this.text = 'Oops, service must not be working.'; });
  }
  click2() {
    let svc_2_endpoint = environment.local === true ? 'http://' + environment.apiBaseUrl + ":" + environment.api_gateway_port + '/text2' : 'http://localhost:5001/text' ;
    this.http.get(svc_2_endpoint, {responseType: 'text'})
      .toPromise()
      .then((res) => {
        this.text2 = res;
      }, e => { this.text2 = 'Oops, service must not be working.'; });
  }
}
