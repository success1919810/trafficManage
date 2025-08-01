import http from '@ohos.net.http';

export async function errorSubmitService<T>(url: string): Promise<T> {
  const httpRequest = http.createHttp();
  try {
    const response = await httpRequest.request(url, {
      method: http.RequestMethod.GET,
      header: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      }
    });
    return JSON.parse(response.result as string) as T;
  } finally {
    httpRequest.destroy();
  }
}