import {Component, OnInit} from '@angular/core';
import {HttpClient} from '@angular/common/http';

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
    this.http.get('http://localhost:5000/text', {responseType: 'text'})
      .toPromise()
      .then((res) => {
          this.text = res;
      }, e => { this.text = 'Oops, service must not be working.'; });
  }
  click2() {
    this.http.get('http://localhost:5001/text', {responseType: 'text'})
      .toPromise()
      .then((res) => {
        this.text2 = res;
      }, e => { this.text2 = 'Oops, service must not be working.'; });
  }
}
