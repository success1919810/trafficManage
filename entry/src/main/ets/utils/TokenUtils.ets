import preferences from '@ohos.data.preferences';
import type { Context } from '@ohos.abilityAccessCtrl'; // 上下文类型

// 存储 token
export async function saveToken(context: Context, token: string) {
  console.log('Attempting to save token:', token);
  const prefs = await preferences.getPreferences(context, 'user_prefs');
  await prefs.put('jwt_token', token);
  await prefs.flush();
}

// 获取 token
export async function getToken(context: Context): Promise<string> {
  const prefs = await preferences.getPreferences(context, 'user_prefs');
  const token = await prefs.get('jwt_token', '') as string;
  return token;
}

// 清除 token
export async function clearToken(context: Context) {
  const prefs = await preferences.getPreferences(context, 'user_prefs');
  await prefs.delete('jwt_token');
  await prefs.flush();
}
