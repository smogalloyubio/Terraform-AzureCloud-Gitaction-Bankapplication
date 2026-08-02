import { Wallet, LogOut, LayoutDashboard, ArrowLeftRight, History as HistoryIcon, User as UserIcon } from 'lucide-react';
import { User, ViewType } from '../types';

interface NavbarProps {
  user: User;
  activeView: ViewType;
  onViewChange: (view: ViewType) => void;
  onLogout: () => void;
}

export default function Navbar({ user, activeView, onViewChange, onLogout }: NavbarProps) {
  const navItems = [
    { id: 'DASHBOARD' as ViewType, label: 'Dashboard', icon: LayoutDashboard },
    { id: 'TRANSFER' as ViewType, label: 'Wire Transfer', icon: ArrowLeftRight },
    { id: 'HISTORY' as ViewType, label: 'Ledger History', icon: HistoryIcon },
  ];

  return (
    <nav id="bank-navbar" className="bg-black border-b border-yellow-400 sticky top-0 z-50">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between h-16">
          
          {/* Logo Brand Segment */}
          <div className="flex items-center gap-3 cursor-pointer" onClick={() => onViewChange('DASHBOARD')}>
            <div className="w-8 h-8 bg-yellow-400 rounded flex items-center justify-center text-black font-bold text-sm tracking-tight">
              S
            </div>
            <span className="font-sans text-xl font-semibold tracking-tight text-white">SimpleBank</span>
            <span className="hidden sm:inline bg-yellow-400 text-black text-[10px] font-semibold px-2.5 py-0.5 rounded-md">
              Sandbox
            </span>
          </div>

          {/* Center Navigation Links */}
          <div className="flex space-x-1 sm:space-x-2 my-auto">
            {navItems.map((item) => {
              const IconComponent = item.icon;
              const isActive = activeView === item.id;
              return (
                <button
                  key={item.id}
                  onClick={() => onViewChange(item.id)}
                  className={`flex items-center gap-2 px-4 py-2 rounded-lg text-sm font-medium transition cursor-pointer ${
                    isActive
                      ? 'bg-yellow-400 text-black'
                      : 'text-zinc-400 hover:bg-zinc-800 hover:text-white'
                  }`}
                >
                  <IconComponent className="w-4 h-4 shrink-0" />
                  <span className="hidden sm:inline">{item.label}</span>
                </button>
              );
            })}
          </div>

          {/* Right Side: Account Actions & User Meta */}
          <div className="flex items-center gap-4">
            <div className="hidden md:flex flex-col text-right">
              <span className="text-xs font-semibold text-white">
                {user.firstName} {user.lastName}
              </span>
              <span className="text-[10px] text-zinc-500 font-mono">
                ID: {user.id}
              </span>
            </div>

            <div className="p-1.5 bg-zinc-800 rounded-full md:hidden">
              <UserIcon className="w-4 h-4 text-zinc-400" />
            </div>

            <div className="h-6 w-px bg-zinc-700"></div>

            <button
              onClick={onLogout}
              className="p-2 text-zinc-400 hover:text-yellow-400 rounded-lg transition cursor-pointer"
              title="Sign Out"
            >
              <LogOut className="w-4.5 h-4.5" />
            </button>
          </div>

        </div>
      </div>
    </nav>
  );
}
