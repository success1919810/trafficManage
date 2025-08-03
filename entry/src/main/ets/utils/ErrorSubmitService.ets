import http from '@ohos.net.http';
import { getToken } from './TokenUtils'
export async function errorSubmitService<T>(url: string,context:Context): Promise<T> {
  const token = await getToken(context)
  const httpRequest = http.createHttp();
  try {
    const response = await httpRequest.request(url, {
      method: http.RequestMethod.GET,
      header: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": `Bearer ${token}`
      }
    });
    return JSON.parse(response.result as string) as T;
  } finally {
    httpRequest.destroy();
  }
}