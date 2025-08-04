import preferences from '@ohos.data.preferences';
import type { Context } from '@ohos.abilityAccessCtrl'; // 上下文类型

// 存储 token
export async function saveToken(context: Context, token: string) {
  console.log('Attempting to save token:', token);
  const prefs = await preferences.getPreferences(context, 'user_prefs');
  await prefs.put('jwt_token', token);
  await prefs.flush();

  // 同步到全局状态
  AppStorage.setOrCreate('userToken', token);
}

// 获取 token
export async function getToken(context: Context): Promise<string> {
  const prefs = await preferences.getPreferences(context, 'user_prefs');
  const token = await prefs.get('jwt_token', '') as string;

  // 同步到全局状态
  if (token) {
    AppStorage.setOrCreate('userToken', token);
  }

  return token;
}

// 清除 token
export async function clearToken(context: Context) {
  const prefs = await preferences.getPreferences(context, 'user_prefs');
  await prefs.delete('jwt_token');
  await prefs.flush();

  // 清除全局状态
  AppStorage.setOrCreate('userToken', '');
}

// 存储用户名
export async function saveUserAccount(context: Context, account: string) {
  console.log('Attempting to save user account:', account);
  const prefs = await preferences.getPreferences(context, 'user_prefs');
  await prefs.put('user_account', account);
  await prefs.flush();

  // 同步到全局状态
  AppStorage.setOrCreate('currentUser', account);
}

// 获取用户名
export async function getUserAccount(context: Context): Promise<string> {
  const prefs = await preferences.getPreferences(context, 'user_prefs');
  const account = await prefs.get('user_account', '') as string;

  // 同步到全局状态
  if (account) {
    AppStorage.setOrCreate('currentUser', account);
  }

  return account;
}

// 清除用户名
export async function clearUserAccount(context: Context) {
  const prefs = await preferences.getPreferences(context, 'user_prefs');
  await prefs.delete('user_account');
  await prefs.flush();

  // 清除全局状态
  AppStorage.setOrCreate('currentUser', '');
}

// 存储完整用户信息（token + 用户名）
export async function saveUserInfo(context: Context, token: string, account: string) {
  await saveToken(context, token);
  await saveUserAccount(context, account);

  // 设置登录状态
  AppStorage.setOrCreate('isLoggedIn', true);
}

// 清除所有用户信息
export async function clearUserInfo(context: Context) {
  await clearToken(context);
  await clearUserAccount(context);

  // 清除登录状态
  AppStorage.setOrCreate('isLoggedIn', false);
}

// 从全局状态获取当前用户名（无需context）
export function getCurrentUser(): string {
  return AppStorage.get('currentUser') as string || '';
}

// 从全局状态获取当前token（无需context）
export function getCurrentToken(): string {
  return AppStorage.get('userToken') as string || '';
}

// 检查登录状态
export function isUserLoggedIn(): boolean {
  return AppStorage.get('isLoggedIn') as boolean || false;
}