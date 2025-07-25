// HttpService.ets

import http from '@ohos.net.http';

export async function postJsonLogin<T>(url: string, data: object): Promise<T> {
  const httpRequest = http.createHttp();

  try {
    const response = await httpRequest.request(url, {
      method: http.RequestMethod.POST,
      header: {
        'Content-Type': 'application/json'
      },
      extraData: JSON.stringify(data)
    });

    return JSON.parse(response.result as string) as T;
  } finally {
    httpRequest.destroy();
  }
}
